variable "role_policy" {
  type = set(string)
  default = [
    "AmazonEC2ContainerRegistryFullAccess",
    "AmazonECSTaskExecutionRolePolicy",
    "AmazonSSMFullAccess",
    "SecretsManagerReadWrite"
  ]
}

data "aws_iam_policy" "policy" {
  for_each = var.role_policy
  name     = each.key
}

resource "aws_iam_role" "ecs_role" {
  name = "ecs_task_definition"
  assume_role_policy = jsonencode({
    Version = "2008-10-17"
    Statement = [
      {
        Sid    = ""
        Effect = "Allow"
        Principal = {
          Service = "ecs-tasks.amazonaws.com"
        }
        Action = "sts:AssumeRole"
      }
    ]
    }
  )
}

resource "aws_iam_role_policy_attachment" "role" {
  for_each   = var.role_policy
  role       = aws_iam_role.ecs_role.name
  policy_arn = data.aws_iam_policy.policy[each.key].arn
}

output "role" {
  value = aws_iam_role.ecs_role.arn
}