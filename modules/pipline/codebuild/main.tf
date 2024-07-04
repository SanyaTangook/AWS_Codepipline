# data "aws_iam_policy_document" "assume_role" {
#   statement {
#     effect = "Allow"

#     principals {
#       type        = "Service"
#       identifiers = ["codebuild.amazonaws.com"]
#     }

#     actions = ["sts:AssumeRole"]
#   }
# }

# resource "aws_iam_role" "example" {
#   name               = "example"
#   assume_role_policy = data.aws_iam_policy_document.assume_role.json
# }

# data "aws_iam_policy_document" "example" {
#   statement {
#     effect = "Allow"

#     actions = [
#       "logs:CreateLogGroup",
#       "logs:CreateLogStream",
#       "logs:PutLogEvents",
#     ]

#     resources = ["*"]
#   }

#   statement {
#     effect = "Allow"

#     actions = [
#       "ec2:CreateNetworkInterface",
#       "ec2:DescribeDhcpOptions",
#       "ec2:DescribeNetworkInterfaces",
#       "ec2:DeleteNetworkInterface",
#       "ec2:DescribeSubnets",
#       "ec2:DescribeSecurityGroups",
#       "ec2:DescribeVpcs",
#     ]

#     resources = ["*"]
#   }

#   statement {
#     effect    = "Allow"
#     actions   = ["ec2:CreateNetworkInterfacePermission"]
#     resources = ["arn:aws:ec2:us-east-1:123456789012:network-interface/*"]

#     condition {
#       test     = "StringEquals"
#       variable = "ec2:Subnet"

#       values = [
#         aws_subnet.example1.arn,
#         aws_subnet.example2.arn,
#       ]
#     }

#     condition {
#       test     = "StringEquals"
#       variable = "ec2:AuthorizedService"
#       values   = ["codebuild.amazonaws.com"]
#     }
#   }

#   statement {
#     effect  = "Allow"
#     actions = ["s3:*"]
#     resources = [
#       aws_s3_bucket.example.arn,
#       "${aws_s3_bucket.example.arn}/*",
#     ]
#   }
# }

# resource "aws_iam_role_policy" "example" {
#   role   = aws_iam_role.example.name
#   policy = data.aws_iam_policy_document.example.json
# }

resource "aws_codebuild_project" "example" {
  name          = "test-project"
  build_timeout = 5
  service_role  = ""

  artifacts {
    type = "CODEPIPELINE"
  }

  environment {
    compute_type                = "BUILD_GENERAL1_SMALL"
    image                       = "aws/codebuild/amazonlinux2-x86_64-standard:4.0"
    type                        = "LINUX_CONTAINER"
    image_pull_credentials_type = "CODEBUILD"

    dynamic "environment_variable" {
      for_each = var.environment_variable
        content {
          name = environment_variable.value.name
          value = environment_variable.value.value
        }
    }
    environment_variable {
      name  = "SOME_KEY1"
      value = "SOME_VALUE1"
    }

    environment_variable {
      name  = "SOME_KEY2"
      value = "SOME_VALUE2"
      type  = "PARAMETER_STORE"
    }
  }

  source {
    type = "NO_SOURCE"
    buildspec = var.buildspec
  }
}

output "sts" {
  value = aws_codebuild_project.example.environment
}

variable "environment_variable" {
    type = map(object({
      name = string
      value = string 
    })) 
    default = {
      "name" = {
        name = "dd"
        value ="dd"
      }
      "test" = {
        name = "ds"
        value = "ds"
      }
    }
}


