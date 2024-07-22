resource "aws_ecr_repository" "aws_ecr_repository" {
    for_each = toset(var.ecr_name)
    name = each.value
}