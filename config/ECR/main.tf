module "ECR" {
  source = "../../modules/ECR"
  ecr_name = var.ecr_name
}
