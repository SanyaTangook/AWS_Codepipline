variable "provider" {
  type = object({
    provider = string
    access_key = string
    secret_key = string
  })

  default = {
    provider = "ap-southeast-1"
    access_key = ""
    secret_key = ""
  }
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