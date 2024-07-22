resource "aws_service_discovery_http_namespace" "namespace" {
  name        = var.ecs_cluster
}

resource "aws_ecs_cluster" "ecs_cluster" {
  name = var.ecs_cluster
  service_connect_defaults {
    namespace = aws_service_discovery_http_namespace.namespace.arn
  }
}
