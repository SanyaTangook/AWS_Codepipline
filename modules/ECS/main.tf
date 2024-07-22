resource "aws_ecs_cluster" "ecs_cluster" {
  name = var.ecs_cluster
}

data "aws_iam_role" "IAM" {
  name = var.role_ecs
}

resource "aws_ecs_task_definition" "task_definition" {
  family                   = var.family
  container_definitions = <<TASK_DEFINITION
  [
    {
      "name": "${var.family}",
      "image": "${var.url_ecr}/${var.family}:latest",
      "cpu": 0,
      "portMappings": [
          {
            "containerPort": 80,
            "hostPort": 80,
            "protocol": "tcp",
            "appProtocol": "http"
          }
        ],
      "essential": true,
      "environment": [
        {
          "name": "ASPNETCORE_ENVIRONMENT",
            "value": "Staging"
        }
      ]
    }
  ]

  TASK_DEFINITION
  execution_role_arn = data.aws_iam_role.IAM.arn
  network_mode = "awsvpc"
  cpu = "1024"
  memory = "3072"
  requires_compatibilities =["FARGATE"]
  runtime_platform {
    cpu_architecture = "X86_64"
    operating_system_family = "LINUX"
  }
}


# resource "aws_ecs_service" "ecs_service" {
#   name = ""
#   cluster = ""
#   propagate_tags = "SERVICE"
#   launch_type = "FARGATE"

# }
