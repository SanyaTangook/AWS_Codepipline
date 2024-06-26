output "api_data" {
    value = data.aws_apigatewayv2_api.data_api.cors_configuration[0]
}