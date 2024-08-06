variable "provider_aws" {
  type = object({
    region = string
    access_key = string
    secret_key = string
  })
}

variable "name_role" {
  type = string
}

variable "policy_name" {
  type = string
}