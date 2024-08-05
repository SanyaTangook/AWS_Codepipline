module "ecr_name" {
  source = "../../modules/ECS"
  for_each = var.ECS
  cluster = each.key
  role_ecs = var.role_ecs
  family = each.value
  url_ecr = var.url_ecr
}
