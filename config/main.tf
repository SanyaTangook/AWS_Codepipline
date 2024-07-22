# module "api_gateway" {
#   for_each = var.data_api
#   source = "../modules/api_geteway"
#   name_api = each.key
#   api_id = each.value.Id_original
#   domain_name = each.value.domain_name
#   name_certificate = var.name_certificate
# }

# output "api_gateway" {
#  value = module.api_gateway
# }

# module "test" {
#   source = "../modules/pipline/codebuild"
#   name_codebuile = var.name_codebuile
# }

# output "name" {
#   value = module.test
# }

module "ECR" {
  source   = "../modules/ECR"
  for_each = var.ECS
  ecr_name = each.value
}

module "namespace" {
  source = "../modules/namespace"
  for_each = var.ECS
  ecs_cluster = each.key
}

module "ecr_name" {
  source = "../modules/ECS"
  depends_on = [ module.namespace ]
  for_each = var.ECS
  cluster = each.key
  role_ecs = var.role_ecs
  family = each.value
  url_ecr = var.url_ecr
}