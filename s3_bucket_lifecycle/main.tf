resource "aws_s3_bucket_lifecycle_configuration" "this" {
  bucket                = var.bucket
  expected_bucket_owner = var.expected_bucket_owner

  dynamic "rule" {
    for_each = var.rules
    content {
      id     = rule.value.id
      status = rule.value.status

      # Filter configuration - handle all filter types and conflicts
      dynamic "filter" {
        for_each = rule.value.filter != null ? [rule.value.filter] : []
        content {
          prefix                   = try(filter.value.prefix, null)
          object_size_greater_than = try(filter.value.object_size_greater_than, null)
          object_size_less_than    = try(filter.value.object_size_less_than, null)

          dynamic "tag" {
            for_each = try(filter.value.tag != null ? [filter.value.tag] : [], [])
            content {
              key   = tag.value.key
              value = tag.value.value
            }
          }

          dynamic "and" {
            for_each = try(filter.value.and != null ? [filter.value.and] : [], [])
            content {
              prefix                   = try(and.value.prefix, null)
              object_size_greater_than = try(and.value.object_size_greater_than, null)
              object_size_less_than    = try(and.value.object_size_less_than, null)
              tags                     = try(and.value.tags, null)
            }
          }
        }
      }

      # Expiration configuration
      dynamic "expiration" {
        for_each = rule.value.expiration != null ? [rule.value.expiration] : []
        content {
          date                         = try(expiration.value.date, null)
          days                         = try(expiration.value.days, null)
          expired_object_delete_marker = try(expiration.value.expired_object_delete_marker, null)
        }
      }

      # Transition configurations
      dynamic "transition" {
        for_each = try(rule.value.transitions, [])
        content {
          date          = try(transition.value.date, null)
          days          = try(transition.value.days, null)
          storage_class = transition.value.storage_class
        }
      }

      # Noncurrent version expiration
      dynamic "noncurrent_version_expiration" {
        for_each = rule.value.noncurrent_version_expiration != null ? [rule.value.noncurrent_version_expiration] : []
        content {
          newer_noncurrent_versions = try(noncurrent_version_expiration.value.newer_noncurrent_versions, null)
          noncurrent_days           = noncurrent_version_expiration.value.noncurrent_days
        }
      }

      # Noncurrent version transitions
      dynamic "noncurrent_version_transition" {
        for_each = try(rule.value.noncurrent_version_transitions, [])
        content {
          newer_noncurrent_versions = try(noncurrent_version_transition.value.newer_noncurrent_versions, null)
          noncurrent_days           = noncurrent_version_transition.value.noncurrent_days
          storage_class             = noncurrent_version_transition.value.storage_class
        }
      }

      # Abort incomplete multipart upload
      dynamic "abort_incomplete_multipart_upload" {
        for_each = rule.value.abort_incomplete_multipart_upload != null ? [rule.value.abort_incomplete_multipart_upload] : []
        content {
          days_after_initiation = abort_incomplete_multipart_upload.value.days_after_initiation
        }
      }
    }
  }
}