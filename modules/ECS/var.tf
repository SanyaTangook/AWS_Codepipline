variable "ecs_cluster" {
  type = list(string)
  default = [""]
}

variable "role_ecs" {
  type = string
  default = ""
}

variable "family" {
  type = string
  default = ""
}
variable "url_ecr" {
  type = string
  default = ""
}