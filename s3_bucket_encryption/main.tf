resource "aws_s3_bucket_server_side_encryption_configuration" "this" {
  bucket = var.bucket
  expected_bucket_owner = var.expected_bucket_owner

  rule {
    bucket_key_enabled = var.bucket_key_enabled

    dynamic "apply_server_side_encryption_by_default" {
      for_each = var.sse_algorithm != null ? [1] : []
      content {
        sse_algorithm     = var.sse_algorithm
        kms_master_key_id = var.kms_master_key_id
      }
    }
  }
}