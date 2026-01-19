resource "aws_s3_bucket_intelligent_tiering_configuration" "this" {
  bucket = var.bucket
  name   = var.name

  dynamic "tiering" {
    for_each = var.tiering
    content {
      days        = tiering.value.days
      access_tier = tiering.value.access_tier
    }
  }

  dynamic "filter" {
    for_each = var.filter == null ? [] : [var.filter]
    content {
      prefix = lookup(filter.value, "prefix", null)
      tags   = lookup(filter.value, "tags", null)
    }
  }
}