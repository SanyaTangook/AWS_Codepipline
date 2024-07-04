variable "name_pipeline" {
  type = string
  default = ""
}

variable "artifact_store" {
  type = object({
    name = string
    type = string
    encryption_key = object({
      name = string
      type = string
    })
  })
  default = {
    name = ""
    type = "S3"
    encryption_key = {
      name = ""
      type = "KMS"
    }
  }
}

variable "arn_Source_provider" {
    type = string
    default = ""
}

variable "Repository" {
  type = object({
    FullRepository = string
    BranchName = string
  })
  default = {
    FullRepository = ""
    BranchName = "main"
  }
}