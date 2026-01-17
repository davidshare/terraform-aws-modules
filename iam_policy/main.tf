resource "aws_iam_policy" "this" {
  name        = var.name
  name_prefix = var.name_prefix
  path        = var.path
  description = var.description

  policy = var.policy

  tags = var.tags
}
