data "aws_api_gateway_domain_name" "example" {
  domain_name = var.api_domain
}

data "aws_apigatewayv2_api" "example" {
  api_id = var.api_id
}