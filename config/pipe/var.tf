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