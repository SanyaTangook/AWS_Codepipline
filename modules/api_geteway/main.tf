data "aws_apigatewayv2_api" "data_api" {
  api_id = var.api_id
}

resource "aws_apigatewayv2_api" "example" {
  name                         = var.name_api
  protocol_type                = "HTTP"
  api_key_selection_expression = data.aws_apigatewayv2_api.data_api.api_key_selection_expression
  cors_configuration {
    allow_credentials = data.aws_apigatewayv2_api.data_api.cors_configuration[0].allow_credentials
    allow_headers = data.aws_apigatewayv2_api.data_api.cors_configuration[1]
    allow_methods = data.aws_apigatewayv2_api.data_api.cors_configuration[2]
    expose_headers = data.aws_apigatewayv2_api.data_api.cors_configuration[4]
    max_age = data.aws_apigatewayv2_api.data_api.cors_configuration[5]
  }
  disable_execute_api_endpoint = data.aws_apigatewayv2_api.data_api.disable_execute_api_endpoint
}
