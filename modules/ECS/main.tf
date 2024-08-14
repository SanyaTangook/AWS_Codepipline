resource "aws_ecs_task_definition" "task_definition" {
  family                   = var.container.name
  container_definitions    = local.container
  execution_role_arn       = var.role
  network_mode             = "awsvpc"
  cpu                      = "1024"
  memory                   = "3072"
  requires_compatibilities = ["FARGATE"]
  runtime_platform {
    cpu_architecture        = "X86_64"
    operating_system_family = "LINUX"
  }
}