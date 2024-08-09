resource "aws_codebuild_project" "codebuild" {
  depends_on = [ aws_iam_role.role ]
  for_each      = var.codebuile
  name          = each.key
  build_timeout = 15
  service_role  = aws_iam_role.role[each.key].arn
  artifacts {
    type = "CODEPIPELINE"
  }
  environment {
    type = each.value["environment"]["type"]
    compute_type = each.value["environment"]["compute_type"]
    image = each.value["environment"]["image"]
    dynamic "environment_variable" {
      for_each = each.value["environment"]["environment_variable"]
      content {
        name = environment_variable.key
        value = environment_variable.value
      }
    }
  }
  source {
    type = "CODEPIPELINE"
  }
  logs_config {
    cloudwatch_logs {
      group_name = "/aws/codebuild/${each.key}"
      status     = "ENABLED"
    }
  }
}

resource "aws_codebuild_report_group" "report_group" {
  depends_on = [ aws_iam_role.role ]
  for_each = var.codebuile
  name = "${each.key}-LCOVINFO-AutoDiscovered"
  type = "CODE_COVERAGE"
  export_config {
    type = "NO_EXPORT"
  }
}

resource "aws_cloudwatch_log_group" "log_codebuild" {
  depends_on = [ aws_iam_role.role ]
  for_each = var.codebuile
  name            = "/aws/codebuild/${each.key}"
  log_group_class = "STANDARD"
}

#  IAM Role CodeBuile
resource "aws_iam_role" "role" {
  for_each           = var.codebuile
  name               = "codebuild-${each.key}-service-role"
  assume_role_policy = file("${path.module}/role_policy/codebuild.json")
}

resource "aws_iam_policy" "policy" {
  for_each = var.codebuile
  name = "CodeBuildBasePolicy-${each.key}"
  policy = jsonencode({
    "Version" = "2012-10-17"
    "Statement" = [
      {
        "Effect" = "Allow",
        "Resource" = [
          "${aws_cloudwatch_log_group.log_codebuild[each.key].arn}",
          "${aws_cloudwatch_log_group.log_codebuild[each.key].arn}:*"
        ],
        "Action" = [
          "logs:CreateLogGroup",
          "logs:CreateLogStream",
          "logs:PutLogEvents"
        ]
      },
      {
        "Effect" = "Allow",
        "Resource" = [
          "${data.aws_s3_bucket.codepipeline.arn }"
        ],
        "Action" = [
          "s3:PutObject",
          "s3:GetObject",
          "s3:GetObjectVersion",
          "s3:GetBucketAcl",
          "s3:GetBucketLocation"
        ]
      },
      {
        "Effect" = "Allow",
        "Action" = [
          "codebuild:CreateReportGroup",
          "codebuild:CreateReport",
          "codebuild:UpdateReport",
          "codebuild:BatchPutTestCases",
          "codebuild:BatchPutCodeCoverages"
        ],
        "Resource" = [
          "${trimsuffix(aws_codebuild_report_group.report_group[each.key].arn, "-LCOVINFO-AutoDiscovered")}-*"
        ]
      }
    ]
  })
}

resource "aws_iam_policy" "fullclone" {
  name = "connection-permissions-fullclone"
  policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Effect" : "Allow",
        "Action" : "codestar-connections:UseConnection",
        "Resource" : "${data.aws_codestarconnections_connection.GitLab.arn}"
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "EC2Full" {
  for_each   = var.codebuile
  role       = aws_iam_role.role[each.key].name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryFullAccess"
}

resource "aws_iam_role_policy_attachment" "codebuild" {
  for_each = var.codebuile
  role       = aws_iam_role.role[each.key].name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMReadOnlyAccess"
}

resource "aws_iam_role_policy_attachment" "AWSCodePipelineServiceRole" {
  for_each = var.codebuile
  role       = aws_iam_role.role[each.key].name
  policy_arn = aws_iam_policy.policy[each.key].arn
}