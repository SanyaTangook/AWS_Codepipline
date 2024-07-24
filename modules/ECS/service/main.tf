

resource "aws_ecs_service" "ecs_service" {
  for_each = toset(var.family)
  name = each.value
  cluster = data.aws_ecs_cluster.ecs-id.id
  task_definition = data.aws_ecs_task_definition.task_definition[each.value].arn
  propagate_tags = "SERVICE"
  launch_type = "FARGATE"
  desired_count = 1
  iam_role = var.iam_role

  network_configuration {
    subnets = [ "172.31.32.0/20" ]
    security_groups = [ "sg-0c2ee03e79dee5fb7" ]
    assign_public_ip = false
  }

  # load_balancer {
  #   target_group_arn = ""
  #   container_name = ""
  #   container_port = ""
  # }
}
