# Create IAM policy document for ECR repository
data "aws_iam_policy_document" "policy_doc" {
  dynamic "statement" {
    for_each = var.statements
    content {
      sid    = statement.value.sid
      effect = statement.value.effect

      actions = statement.value.actions

      dynamic "principals" {
        for_each = statement.value.principals
        content {
          type        = principals.value.type
          identifiers = principals.value.identifiers
        }
      }

      resources = statement.value.resources
    }
  }
}

# Apply policy to ECR repository
resource "aws_ecr_repository_policy" "this" {
  repository = var.repository
  policy     = data.aws_iam_policy_document.policy_doc.json
}
