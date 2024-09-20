module "ecs_name" {
  source    = "../../modules/ECS"
  for_each = var.container
  role = "arn:aws:iam::***********:role/ecsTaskExecutionRole-prd"
  container = var.container[each.key]
}


module "role" {
  source = "../../modules/ECS/role"
}

output "role" {
  value = module.role.role
}
