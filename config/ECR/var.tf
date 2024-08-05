variable "provider_aws" {
  type = object({
    region = string
    access_key = string
    secret_key = string
  })
}
variable "role_ecs" {
  type = string
  default = ""
}

variable "url_ecr" {
  type = string
}

variable "ECS" {
  type = map(list(string))
  default = {
    "cluster" = [ "task" ]
  }  
}
