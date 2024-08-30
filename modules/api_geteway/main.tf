#  ดึงของ Data เก่ามาสร้าง
data "aws_apigatewayv2_api" "data_api" {
  api_id = var.api_id
}

data "aws_acm_certificate" "issued" {
  domain   = var.name_certificate
  statuses = ["ISSUED"]
}

resource "aws_apigatewayv2_api" "creat_api" {
  name                         = var.name_api
  protocol_type                = "HTTP"
  api_key_selection_expression = data.aws_apigatewayv2_api.data_api.api_key_selection_expression
  cors_configuration {
    allow_credentials = data.aws_apigatewayv2_api.data_api.cors_configuration[0].allow_credentials
    allow_headers     = data.aws_apigatewayv2_api.data_api.cors_configuration[0].allow_headers
    allow_methods     = data.aws_apigatewayv2_api.data_api.cors_configuration[0].allow_methods
    expose_headers    = data.aws_apigatewayv2_api.data_api.cors_configuration[0].expose_headers
    max_age           = data.aws_apigatewayv2_api.data_api.cors_configuration[0].max_age
    allow_origins     = data.aws_apigatewayv2_api.data_api.cors_configuration[0].allow_origins
  }
  disable_execute_api_endpoint = data.aws_apigatewayv2_api.data_api.disable_execute_api_endpoint
  route_selection_expression   = data.aws_apigatewayv2_api.data_api.route_selection_expression
}

resource "aws_apigatewayv2_route" "api_route" {
  depends_on = [aws_apigatewayv2_api.creat_api]
  api_id     = aws_apigatewayv2_api.creat_api.id
  route_key  = "ANY /{proxy+}"
}

resource "aws_apigatewayv2_stage" "api_gateway" {
  depends_on  = [aws_apigatewayv2_route.api_route]
  api_id      = aws_apigatewayv2_api.creat_api.id
  name        = "$default"
  auto_deploy = true
}

resource "aws_apigatewayv2_domain_name" "creat_domain" {
  depends_on  = [aws_apigatewayv2_api.creat_api]
  domain_name = var.domain_name

  domain_name_configuration {
    certificate_arn = data.aws_acm_certificate.issued.arn
    endpoint_type   = "REGIONAL"
    security_policy = "TLS_1_2"
  }
}
