
/*--------------resource---------------- */

resource "aws_iam_policy" "policy" {
  name   = var.policy
  policy = file("${path.module}/CodePipeline.json")
}

resource "aws_iam_role" "role" {
  name = var.role
  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Principal = {
          Service = "codepipeline.amazonaws.com"
        },
        Action = "sts:AssumeRole"
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "AmazonEC2ContainerRegistryFullAccess" {
  role       = aws_iam_role.role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryFullAccess"
}

resource "aws_iam_role_policy_attachment" "AWSCodePipelineServiceRole" {
  role       = aws_iam_role.role.name
  policy_arn = aws_iam_policy.policy.arn
}