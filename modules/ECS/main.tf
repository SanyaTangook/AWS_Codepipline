resource "aws_ecs_cluster" "ecs_cluster" {
  name = var.ecs_cluster
}

resource "aws_ecs_task_definition" "task_definition" {
  family                   = ""
  container_definitions    = <<TASK_DEFINITION
  [
    {
    "name": "sg-tst_cdp",
            "image": "",
            "cpu": 0,
            "portMappings": [
                {
                    "name": "",
                    "containerPort": ,
                    "hostPort": ,
                    "protocol": "",
                    "appProtocol": ""
                }
            ],
            "essential": ,
            "environment": [
                {
                    "name": "",
                    "value": ""
                }
            ],
            "secrets": [
                {
                    "name": "",
                    "valueFrom": ""
                }
            ],
            "logConfiguration": {
                "logDriver": "",
                "options": {}
    }
  ]
  TASK_DEFINITION
  execution_role_arn = ""
  network_mode = "awsvpc"
  cpu = "1024"
  memory = "3072"
  requires_compatibilities = "FARGATE"
  runtime_platform {
    cpu_architecture = "X86_64"
    operating_system_family = "LINUX"
  }
}
