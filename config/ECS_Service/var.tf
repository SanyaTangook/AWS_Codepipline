variable "region" {
  type    = string
  default = "ap-southeast-1"
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