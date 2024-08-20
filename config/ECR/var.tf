# API gateway variable 
variable "provider_aws" {
  type = object({
    region     = string
    access_key = string
    secret_key = string
  })
}

variable "ecr_name" {
    type = list(string)
}