data "aws_iam_role" "IAM" {
  name = var.role_ecs
}

resource "aws_ecs_task_definition" "task_definition" {
  for_each                 = var.container
  family                   = each.key
  container_definitions    = jsonencode([each.value])
  execution_role_arn       = data.aws_iam_role.IAM.arn
  network_mode             = "awsvpc"
  cpu                      = "1024"
  memory                   = "3072"
  requires_compatibilities = ["FARGATE"]
  runtime_platform {
    cpu_architecture        = "X86_64"
    operating_system_family = "LINUX"
  }
}


output "task_definition" {
  value = aws_ecs_task_definition.task_definition
}