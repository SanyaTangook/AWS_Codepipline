data "aws_apigatewayv2_api" "data_api" {
  api_id = var.api_id
}

resource "aws_apigatewayv2_api" "example" {
  name                         = var.name_api
  protocol_type                = "HTTP"
  api_key_selection_expression = data.aws_apigatewayv2_api.data_api.api_key_selection_expression
  cors_configuration {
    allow_credentials = true
    allow_headers = ["*",
      "accept",
      "authorization",
      "content-type",
      "loading",
      "origin",
      "x-requested-with",
    ]
    allow_methods = [
      "*",
      "DELETE",
      "GET",
      "HEAD",
      "OPTIONS",
      "PATCH",
      "POST",
      "PUT",
    ]
    expose_headers = [ "*" ]
    max_age = 300
  }
  disable_execute_api_endpoint = data.aws_apigatewayv2_api.data_api.disable_execute_api_endpoint
}
