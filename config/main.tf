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
  for_each     = var.service_name
  service_name = each.value.service_name
  cluster_arn  = each.value.cluster_arn
}

data "aws_ecs_container_definition" "ecs-mongo" {
  for_each        = var.container
  task_definition = each.value.task_definition
  container_name  = each.value.container_name
}

output "ecs" {
  value = data.aws_ecs_service.example
}

output "container" {
  value = data.aws_ecs_container_definition.ecs-mongo
}