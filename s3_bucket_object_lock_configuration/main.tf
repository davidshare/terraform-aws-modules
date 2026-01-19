resource "aws_s3_bucket_object_lock_configuration" "this" {
  bucket                = var.bucket
  expected_bucket_owner = var.expected_bucket_owner
  object_lock_enabled   = var.object_lock_enabled

  dynamic "rule" {
    for_each = var.rule != null ? [var.rule] : []
    content {
      dynamic "default_retention" {
        for_each = rule.value.default_retention != null ? [rule.value.default_retention] : []
        content {
          days  = default_retention.value.days
          mode  = default_retention.value.mode
          years = default_retention.value.years
        }
      }
    }
  }
}