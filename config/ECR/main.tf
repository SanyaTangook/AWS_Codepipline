module "ecr_name" {
  source = "../../modules/ECS"
  container = var.container
  role_ecs = var.role_ecs

}

output "ddd" {
  value = module.ecr_name
}