data "aws_iam_policy_document" "example" {
  version = var.version

  # Iterate over the statements from the input variable
  dynamic "statement" {
    for_each = var.statements
    content {
      sid       = statement.value.sid
      actions   = statement.value.actions
      effect    = statement.value.effect
      resources = statement.value.resources

      not_actions    = statement.value.not_actions
      not_resources  = statement.value.not_resources
      not_principals = statement.value.not_principals

      condition {
        test     = statement.value.condition_test
        variable = statement.value.condition_variable
        values   = statement.value.condition_values
      }

      # Define principals for the statement
      dynamic "principals" {
        for_each = statement.value.principals
        content {
          type        = principals.value.type
          identifiers = principals.value.identifiers
        }
      }
    }
  }

  source_policy_documents   = var.source_policy_documents
  override_policy_documents = var.override_policy_documents
}