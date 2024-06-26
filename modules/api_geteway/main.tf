data "aws_apigatewayv2_api" "data_api" {
  api_id = var.api_id
}

data "aws_lb" "selected" {
  name = var.lb_listener
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
  api_id    = aws_apigatewayv2_api.creat_api.id
  route_key = "ANY /{proxy+}"
}


resource "aws_apigatewayv2_integration" "example" {
  api_id           = aws_apigatewayv2_api.creat_api.id
  description      = "Example with a load balancer"
  integration_type = "HTTP_PROXY"
  integration_uri  = data.aws_lb.selected.arn

  integration_method = "ANY"
  connection_type    = "VPC_LINK"
  connection_id      = var.vpc_id

}