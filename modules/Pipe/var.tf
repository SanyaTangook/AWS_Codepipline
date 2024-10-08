variable "S3" {
  type = string
}

variable "pipeline" {
  type = map(object({
    Repository = object({
      RepositoryName = string
      BranchName     = string
    })
    CodeBuild = string
    Deploy = object({
      Cluster = string
      Service = string
    })
  }))
}
variable "GitLab" {
  type = string
}

data "aws_s3_bucket" "codepipeline" {
  bucket = var.S3
}

data "aws_codestarconnections_connection" "GitLab" {
  name = var.GitLab
}