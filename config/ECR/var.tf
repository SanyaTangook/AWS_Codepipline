variable "region" {
  type    = string
  default = "ap-southeast-1"
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
