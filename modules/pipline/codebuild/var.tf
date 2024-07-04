variable "buildspec" {
  type = string
  default = ""
}

variable "environment_variable" {
    type = map(object({
      name = string
      value = string 
    })) 
}


variable "name_codebuile" {
  type = string
}

