resource "aws_iam_instance_profile" "instance_profile" {
  name        = var.name
  role        = var.role
  path        = var.path
  tags        = var.tags
  name_prefix = var.name_prefix
}