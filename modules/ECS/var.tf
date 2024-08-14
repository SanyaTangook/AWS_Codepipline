variable "container" {
  type = object({
    name         = string
    image        = string
    cpu          = number
    essential    = bool
    environment  = list(map(string))
    secrets      = list(map(string))
  })
}

variable "role" {
  type = string
}

locals {
  name_container =lower(var.container.name) 
  container = jsonencode([
    {
      name = "${local.name_container}"
      image = "${var.container.image}"
      cpu = 0,
      portMappings = [
        {
          name = "${local.name_container}-80-tcp"
          containerPort = 80
          hostPort = 80
          protocol = "tcp"
          appProtocol = "http"
      }]
      environmentFiles = []
      ulimits = []
      essential = true
      environment = var.container.environment 
      mountPoints = []
      volumesFrom = []
      secrets = var.container.secrets 
      logConfiguration = {
        logDriver = "awslogs"
        options = {
          awslogs-group = "/ecs/${local.name_container}"
          awslogs-create-group = "true"
          awslogs-region = "ap-southeast-1"
          awslogs-stream-prefix = "ecs"
        }
        secretOptions = []
      }
      systemControls = []
    }
  ])
}