variable "provider_aws" {
  type = object({
    region = string
    access_key = string
    secret_key = string
  })
}
variable "ECS" {
  type = map(list(string))
  default = {
    "cluster" = [ "task" ]
  }  
}

variable "iam_role" {
  type = string
}