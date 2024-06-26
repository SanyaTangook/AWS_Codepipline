data "aws_apigatewayv2_api" "data_api" {
  api_id = var.api_id
}

resource "aws_apigatewayv2_api" "example" {
  name                         = var.name_api
  protocol_type                = "HTTP"
  api_key_selection_expression = data.aws_apigatewayv2_api.data_api.api_key_selection_expression
  cors_configuration {
    allow_credentials = data.aws_apigatewayv2_api.data_api.cors_configuration[0].allow_credentials
    allow_headers = data.aws_apigatewayv2_api.data_api.cors_configuration[0].allow_headers
    allow_methods = data.aws_apigatewayv2_api.data_api.cors_configuration[0].allow_methods
    expose_headers = data.aws_apigatewayv2_api.data_api.cors_configuration[0].expose_headers
    max_age = data.aws_apigatewayv2_api.data_api.cors_configuration[0].max_age
  }
  disable_execute_api_endpoint = data.aws_apigatewayv2_api.data_api.disable_execute_api_endpoint
  route_key = "ANY /{proxy+}"
}
