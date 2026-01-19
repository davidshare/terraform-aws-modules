resource "aws_s3_bucket_inventory" "this" {
  bucket = var.bucket
  name   = var.name

  enabled                  = var.enabled
  included_object_versions = var.included_object_versions
  optional_fields          = var.optional_fields

  dynamic "destination" {
    for_each = [var.destination]
    content {
      dynamic "bucket" {
        for_each = [destination.value.bucket]
        content {
          format     = bucket.value.format
          bucket_arn = bucket.value.bucket_arn
          prefix     = lookup(bucket.value, "prefix", null)
          account_id = lookup(bucket.value, "account_id", null)
        }
      }
    }
  }

  dynamic "schedule" {
    for_each = var.schedule == null ? [] : [var.schedule]
    content {
      frequency = schedule.value.frequency
    }
  }
}