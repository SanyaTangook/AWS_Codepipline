variable "family" {
  type = list(string)
  default = [""]
}

variable "cluster" {
  type = string
}

variable "iam_role" {
  type = string
  default = ""
}

data "aws_ecs_task_definition" "task_definition" {
  for_each = toset(var.family)
  task_definition = "${each.value}"
}

data "aws_ecs_cluster" "ecs-id" {
  cluster_name = var.cluster
}
