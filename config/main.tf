module "api_gateway" {
  for_each = var.data_api
  source   = "../modules/api_geteway"
  api_id   = each.value
  name_api = each.key
}

output "api_gateway" {
  value = module.api_gateway
}