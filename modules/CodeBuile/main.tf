resource "aws_codebuild_project" "codebuild" {
  name          = var.name-codebuild
  build_timeout = 15
  service_role  = data.aws_iam_role.codebuild.arn

  artifacts {
    type = "CODEPIPELINE"
  }

  environment {
    compute_type                = var.environment.compute_type
    image                       = var.environment.image
    type                        = var.environment.type
    image_pull_credentials_type = "CODEBUILD"

    dynamic "environment_variable" {
      for_each = var.environment_variable
      content {
        name  = environment_variable.key
        value = environment_variable.value
      }
    }
  }

  source {
    type = "CODEPIPELINE"
  }
}