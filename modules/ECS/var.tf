variable "role_ecs" {
  type = string
  default = ""
}

variable "family" {
  type = list(string)
  default = [""]
}

variable "cluster" {
  type = string
  default = ""
}

variable "url_ecr" {
  type = string
  default = ""
}