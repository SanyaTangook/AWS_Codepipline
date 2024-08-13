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


variable "container" {
  type = map(object({
    image = string
    cpu = number
    essential = bool
    environment = list(map(string))
    secrets = list(map(string))
  }))
  default = {
    "ecr_name" = {
      image = ""
      cpu = 0 
      essential = false
      environment = [{
        "key" = "value"
      }]
      secrets = [{
        "key" = "value"
      }]
    }
  }
}