output "ecs_cluster" {
  value = {
    for ids in aws_ecs_cluster.ecs_cluster.id :ids => tostring(ids)
  }
}