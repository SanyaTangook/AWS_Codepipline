resource "aws_codepipeline" "codepipeline" {
  name          = var.Name-pipeline
  role_arn      = data.aws_iam_role.role_pipeline.arn
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
        FullRepositoryId = var.Repository.RepositoryName
        BranchName       = var.Repository.BranchName
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
        ProjectName = var.CodeBuild
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
        ClusterName = var.Deploy.Cluster
        ServiceName = var.Deploy.Service
        FileName    = "imagedefinitions.json"
      }
    }
  }
}