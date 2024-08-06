variable "provider_aws" {
  type = object({
    region     = string
    access_key = string
    secret_key = string
  })
}

variable "S3" {
  type = string
}

variable "Name-pipeline" {
  type = string
}

variable "Repository" {
  type = object({
    RepositoryName = string
    BranchName     = string
  })
}

variable "CodeBuild" {
  type = string
}

variable "Deploy" {
  type = object({
    Cluster = string
    Service = string
  })
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

data "aws_iam_role" "role_pipeline" {
  name = "AWSCodePipelineServiceRole"
}
