resource "aws_iam_role" "this" {
  name                  = var.name
  name_prefix           = var.name_prefix
  path                  = var.path
  description           = var.description
  assume_role_policy    = var.assume_role_policy
  max_session_duration  = var.max_session_duration
  permissions_boundary  = var.permissions_boundary
  force_detach_policies = var.force_detach_policies
  tags                  = var.tags
}
