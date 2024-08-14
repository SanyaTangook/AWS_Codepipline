variable "provider_aws" {
  type = object({
    region     = string
    access_key = string
    secret_key = string
  })
}
variable "role_ecs" {
  type    = string
  default = ""
}


variable "container" {
  type = map(object({
    name        = string
    image       = string
    cpu         = number
    essential   = bool
    environment = list(map(string))
    secrets     = list(map(string))
  }))
}