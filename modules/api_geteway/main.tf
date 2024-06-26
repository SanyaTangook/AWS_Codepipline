data "aws_apigatewayv2_api" "data_api" {
  api_id = var.api_id
}

data "aws_apigatewayv2_vpc_link" "id_vpc" {
  vpc_link_id = var.id_vpc
}

data "aws_lb" "get_lb" {
  name = var.lb
}

data "aws_lb_listener" "lb_listener" {
  arn = data.aws_lb.get_lb.arn
  port = 80
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
  }
  disable_execute_api_endpoint = data.aws_apigatewayv2_api.data_api.disable_execute_api_endpoint
  route_selection_expression   = data.aws_apigatewayv2_api.data_api.route_selection_expression
}


resource "aws_apigatewayv2_route" "example" {
  api_id    = aws_apigatewayv2_api.creat_api.id
  route_key = "ANY /{proxy+}"
}

resource "aws_apigatewayv2_integration" "example" {
  api_id           = aws_apigatewayv2_api.creat_api.id
  integration_type = "HTTP_PROXY"

  integration_method = "ANY"
  integration_uri    =  data.aws_lb.get_lb.arn

  connection_type    = "VPC_LINK"
  connection_id      = data.aws_apigatewayv2_vpc_link.id_vpc.id
}
