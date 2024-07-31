# API gateway variable 
variable "name_certificate" {
  type = string
}

variable "region" {
  type    = string
  default = "ap-southeast-1"
}

variable "data_api" {
  type = map(object({
    Id_original = string
    domain_name = string 
  }))
}