module "ecr_name" {
  source    = "../../modules/ECS"
  for_each = var.container
  container = var.container[each.key]
}