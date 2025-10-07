resource "aws_amplify_app" "this" {
  name         = var.name
  repository   = var.repository
  oauth_token  = var.oauth_token
  access_token = var.access_token

  description                 = var.description
  enable_branch_auto_build    = var.enable_branch_auto_build
  enable_branch_auto_deletion = var.enable_branch_auto_deletion
  iam_service_role_arn        = var.iam_service_role_arn
  platform                    = var.platform
  build_spec                  = var.build_spec

  dynamic "custom_rule" {
    for_each = var.custom_rules
    content {
      source = custom_rule.value.source
      status = custom_rule.value.status
      target = custom_rule.value.target
    }
  }

  dynamic "environment_variables" {
    for_each = var.environment_variables
    content {
      name  = environment_variables.key
      value = environment_variables.value
    }
  }

  tags = var.tags
}
