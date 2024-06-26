module "api_gateway" {
  for_each = var.data_api
  source   = "../modules/api_geteway"
  api_id   = each.value
  name_api = each.key
  domain_name = var.domain_name
  name_certificate = var.name_certificate
}

output "api_gateway" {
  value = module.api_gateway
}