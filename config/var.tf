# variable "data_api" {
#   type = map(string)
# }

# variable "domain_name" {
#   type = map(string)
# }

# variable "name_certificate" {
#   type = string
# }

variable "region" {
  type    = string
  default = "ap-southeast-1"
}

variable "container" {
  type = object({
    task_definition = string
    container_name  = string
  })
}

variable "service_name" {
  type = object({
    service_name = string
    cluster_arn  = string
  })
}