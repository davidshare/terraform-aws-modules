data "aws_iam_policy_document" "this" {
  policy_id = var.policy_id
  version   = var.version

  dynamic "statement" {
    for_each = var.statement
    content {
      sid       = statement.value.sid
      effect    = statement.value.effect
      actions   = statement.value.actions
      resources = statement.value.resources

      dynamic "condition" {
        for_each = statement.value.condition
        content {
          test     = condition.value.test
          variable = condition.value.variable
          values   = condition.value.values
        }
      }
    }
  }
}
