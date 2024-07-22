data "aws_iam_role" "IAM" {
  name = var.role_ecs
}

resource "aws_ecs_task_definition" "task_definition" {
  for_each = toset(var.family)
  family                   = each.value
  container_definitions = <<TASK_DEFINITION
  [
    {
      "name": "${each.value}",
      "image": "${var.url_ecr}/${each.value}:latest",
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

data "aws_ecs_cluster" "ecs-id" {
  cluster_name = var.cluster
}

# resource "aws_ecs_service" "ecs_service" {
#   for_each = toset(var.family)
#   name = each.value
#   cluster = data.aws_ecs_cluster.ecs-id.id
#   task_definition = aws_ecs_task_definition.task_definition[each.key].arn
#   propagate_tags = "SERVICE"
#   launch_type = "FARGATE"
#   desired_count = 1
#   iam_role = ""

#   network_configuration {
#     subnets = [  ]
#     security_groups = [  ]
#     assign_public_ip = true
#   }

#   load_balancer {
#     target_group_arn = ""
#     container_name = ""
#     container_port = ""
#   }
# }
