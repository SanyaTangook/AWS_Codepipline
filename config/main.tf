# module "api_gateway" {
#   for_each = var.data_api
#   source   = "../modules/api_geteway"
#   api_id   = each.value
#   name_api = each.key
#   domain_name = var.domain_name[each.key]
#   name_certificate = var.name_certificate

# }

# output "api_gateway" {
#   value = module.api_gateway
# }


data "aws_ecs_service" "example" {
  service_name = var.service_name.service_name
  cluster_arn  = var.service_name.cluster_arn
}

data "aws_ecs_container_definition" "ecs-mongo" {
  task_definition = var.container.task_definition
  container_name  = var.container.container_name
}

output "ecs" {
  value = data.aws_ecs_service.example
}