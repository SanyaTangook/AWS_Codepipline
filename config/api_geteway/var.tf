# API gateway variable 
variable "provider_aws" {
  type = object({
    region     = string
    access_key = string
    secret_key = string
  })
}

variable "data_api" {
  type = map(object({
    Id_original = string
    domain_name = string 
  }))
}

variable "name_certificate" {
  type = string
}