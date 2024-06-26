module "api_gateway" {
    source = "../modules/api_geteway"
    api_id = var.api_id
    api_domain = var.api_domain
}

output "api_gateway" {
  value = module.api_gateway
}