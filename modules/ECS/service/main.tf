data "aws_ecs_task_definition" "task_definition" {
  for_each = toset(var.family)
  task_definition = "${each.value}:LATEST"
}

resource "aws_ecs_service" "ecs_service" {
  for_each = toset(var.family)
  name = each.value
  cluster = data.aws_ecs_cluster.ecs-id.id
  task_definition = data.aws_ecs_task_definition.task_definition[each.value].arn
  propagate_tags = "SERVICE"
  launch_type = "FARGATE"
  desired_count = 1

  # network_configuration {
  #   subnets = [  ]
  #   security_groups = [  ]
  #   assign_public_ip = true
  # }

  # load_balancer {
  #   target_group_arn = ""
  #   container_name = ""
  #   container_port = ""
  # }
}
