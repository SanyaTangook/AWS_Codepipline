# API gateway variable 
variable "name_certificate" {
  type = string
}

variable "provider" {
  type = object({
    provider = string
    access_key = string
    secret_key = string
  })

  default = {
    provider = "ap-southeast-1"
    access_key = ""
    secret_key = ""
  }
}

variable "data_api" {
  type = map(object({
    Id_original = string
    domain_name = string 
  }))
}