output "ecs" {
  value = aws_ecs_cluster.ecs_cluster.id[*]
}