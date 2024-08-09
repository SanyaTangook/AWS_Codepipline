resource "aws_codepipeline" "codepipeline" {
  depends_on    = [aws_iam_role_policy_attachment.AWSCodePipelineServiceRole]
  for_each      = var.pipeline
  name          = each.key
  role_arn      = aws_iam_role.role[each.key].arn
  pipeline_type = "V2"
  artifact_store {
    location = data.aws_s3_bucket.codepipeline.bucket
    type     = "S3"
  }

  stage {
    name = "Source"
    action {
      name             = "Source"
      category         = "Source"
      owner            = "AWS"
      provider         = "CodeStarSourceConnection"
      version          = "1"
      output_artifacts = ["SourceArtifact"]
      namespace        = "SourceVariables"
      configuration = {
        ConnectionArn    = data.aws_codestarconnections_connection.GitLab.arn
        FullRepositoryId = var.pipeline["${each.key}"].Repository.RepositoryName
        BranchName       = var.pipeline["${each.key}"].Repository.BranchName
        OutputArtifactFormat = "CODEBUILD_CLONE_REF"
      }
    }
  }

  stage {
    name = "Build"
    action {
      name             = "Build"
      category         = "Build"
      owner            = "AWS"
      provider         = "CodeBuild"
      namespace        = "BuildVariables"
      input_artifacts  = ["SourceArtifact"]
      output_artifacts = ["BuildArtifact"]
      version          = "1"
      configuration = {
        ProjectName = var.pipeline["${each.key}"].CodeBuild
      }
    }
  }

  stage {
    name = "Deploy"
    action {
      name            = "Deploy"
      category        = "Deploy"
      owner           = "AWS"
      provider        = "ECS"
      version         = "1"
      input_artifacts = ["BuildArtifact"]
      namespace       = "DeployVariables"
      configuration = {
        ClusterName = var.pipeline["${each.key}"].Deploy.Cluster
        ServiceName = var.pipeline["${each.key}"].Deploy.Service
        FileName    = "imagedefinitions.json"
      }
    }
  }
}

/* IAM Role Pipeline */

resource "aws_iam_role" "role" {
  depends_on         = [aws_iam_policy.policy]
  for_each           = var.pipeline
  name               = "AWSCodePipelineServiceRole-${each.key}"
  assume_role_policy = file("${path.module}/role_policy/AWSCodePipelineServiceRole.json")
}

resource "aws_iam_policy" "policy" {
  for_each = var.pipeline
  name     = "AWSCodePipelineServiceRole-ap-southeast-1-${each.key}"
  policy   = file("${path.module}/CodePipeline.json")
}

resource "aws_iam_role_policy_attachment" "EC2Full" {
  depends_on = [aws_iam_role.role]
  for_each   = var.pipeline
  role       = aws_iam_role.role[each.key].name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryFullAccess"
}

resource "aws_iam_role_policy_attachment" "AWSCodePipelineServiceRole" {
  depends_on = [aws_iam_role.role]
  for_each   = var.pipeline
  role       = aws_iam_role.role[each.key].name
  policy_arn = aws_iam_policy.policy[each.key].arn
}