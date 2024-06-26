module "api_gateway" {
    source = "../modules/api_geteway"
    api_id = var.api_id
    name_api = var.name_api
}

output "api_gateway" {
  value = module.api_gateway
}