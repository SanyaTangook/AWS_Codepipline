variable "name-codebuild" {
  type = string
}

variable "environment" {
  type = object({
    type         = string
    compute_type = string
    image        = string
  })
}

variable "environment_variable" {
  type = map(string)
}

data "aws_iam_role" "codebuild" {
  name = ""
}