# # API gateway variable 
# variable "name_certificate" {
#   type = string
# }

variable "region" {
  type    = string
  default = "ap-southeast-1"
}

# variable "data_api" {
#   type = map(object({
#     Id_original = string
#     domain_name = string 
#   }))
# }


# # Code Build variable 
# variable "buildspec" {
#   type = string
#   default = ""
# }

# variable "environment_variable" {
#     type = map(object({
#       name = string
#       value = string 
#     })) 
# }


# variable "name_codebuile" {
#   type = string
# }

variable "ecr_name" {
  type    = list(string)
  default = [""]
}

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
}