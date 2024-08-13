variable "role_ecs" {
  type    = string
  default = ""
}

variable "container" {
  type = map(object({
    image       = string
    cpu         = number
    essential   = bool
    environment = list(map(string))
    secrets     = list(map(string))
  }))
}