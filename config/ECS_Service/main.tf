module "ecs_service" {
  source = "../modules/ECS/service"
  for_each = var.ECS
  family = each.value
  cluster = each.key
  iam_role = var.iam_role
}