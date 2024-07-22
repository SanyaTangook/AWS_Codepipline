resource "aws_service_discovery_http_namespace" "namespace" {
  for_each = toset(var.ecs_cluster)
  name        = each.key
}

resource "aws_ecs_cluster" "ecs_cluster" {
  for_each = toset(var.ecs_cluster)
  name = each.key
  service_connect_defaults {
    namespace = aws_service_discovery_http_namespace.namespace[each.key].arn
  }
}
