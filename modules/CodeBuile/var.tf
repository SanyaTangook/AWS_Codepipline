variable "codebuile" {
  type = map(object({
    environment = object({
      type                 = string
      compute_type         = string
      image                = string
      environment_variable = map(string)
    })
  }))
}

variable "s3" {
  type = string
}
variable "GitLab" {
  type = string
}

data "aws_codestarconnections_connection" "GitLab" {
  name = var.GitLab
}
