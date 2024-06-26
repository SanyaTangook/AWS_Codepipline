module "api_gateway" {
  for_each = var.data_api
  source   = "../modules/api_geteway"
  api_id   = each.value
  name_api = each.key
  lb_listener = var.lb_listener[each.key]
  vpc_id = var.vpc_id
}

output "api_gateway" {
  value = module.api_gateway
}