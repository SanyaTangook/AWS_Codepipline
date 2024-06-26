variable "api_id" {
  type    = string
  default = ""
}

variable "name_api" {
  type    = string
  default = ""
}

variable "domain_name" {
  type = set(string)
}

variable "name_certificate" {
  type = string
}