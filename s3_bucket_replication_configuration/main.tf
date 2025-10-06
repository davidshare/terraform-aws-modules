resource "aws_s3_bucket_replication_configuration" "this" {
  bucket = var.bucket
  role   = var.role

  dynamic "rule" {
    for_each = var.rules
    content {
      id     = lookup(rule.value, "id", null)
      status = rule.value.status
      priority = lookup(rule.value, "priority", null)

      dynamic "filter" {
        for_each = length(keys(lookup(rule.value, "filter", {}))) > 0 ? [lookup(rule.value, "filter", {})] : []
        content {
          prefix = lookup(filter.value, "prefix", null)
        }
      }

      delete_marker_replication {
        status = lookup(rule.value, "delete_marker_replication_status", "Disabled")
      }

      destination {
        bucket        = rule.value.destination.bucket
        storage_class = lookup(rule.value.destination, "storage_class", null)
      }

      source_selection_criteria {
        sse_kms_encrypted_objects {
          status = lookup(rule.value, "sse_kms_encrypted_objects_status", "Disabled")
        }
      }
    }
  }
}