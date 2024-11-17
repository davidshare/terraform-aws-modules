resource "aws_iam_role_policy" "this" {
  name        = var.name
  name_prefix = var.name_prefix
  role        = var.role
  policy      = var.policy
}
