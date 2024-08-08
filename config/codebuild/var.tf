variable "provider_aws" {
  type = object({
    region     = string
    access_key = string
    secret_key = string
  })
}

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
