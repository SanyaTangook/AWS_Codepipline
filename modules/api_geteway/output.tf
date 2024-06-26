output "api_domain" {
  value = data.aws_api_gateway_domain_name.example
}

output "api_data" {
  value = data.aws_apigatewayv2_api.example
}