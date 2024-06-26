module "api_gateway" {
    source = "../modules/api_geteway"
    api_id = var.api_id
}

output "api_gateway" {
  value = module.api_gateway.api_data
}