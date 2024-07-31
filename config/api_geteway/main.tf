module "api_gateway" {
  for_each = var.data_api
  source = "../modules/api_geteway"
  name_api = each.key
  api_id = each.value.Id_original
  domain_name = each.value.domain_name
  name_certificate = var.name_certificate
}