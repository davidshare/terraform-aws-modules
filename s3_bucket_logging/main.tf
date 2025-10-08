resource "aws_s3_bucket_logging" "this" {
  bucket = var.bucket
  expected_bucket_owner = var.expected_bucket_owner

  target_bucket = var.target_bucket
  target_prefix = var.target_prefix

  # Target grants configuration for fine-grained permissions
  dynamic "target_grant" {
    for_each = var.target_grants
    content {
      permission = target_grant.value.permission

      grantee {
        type          = target_grant.value.grantee.type
        email_address = try(target_grant.value.grantee.email_address, null)
        id            = try(target_grant.value.grantee.id, null)
        uri           = try(target_grant.value.grantee.uri, null)
      }
    }
  }

  # Target object key format configuration
  dynamic "target_object_key_format" {
    for_each = var.target_object_key_format != null ? [var.target_object_key_format] : []
    content {
      dynamic "partitioned_prefix" {
        for_each = try([target_object_key_format.value.partitioned_prefix], [])
        content {
          partition_date_source = partitioned_prefix.value.partition_date_source
        }
      }

      dynamic "simple_prefix" {
        for_each = try([target_object_key_format.value.simple_prefix], [])
        content {
          # simple_prefix block must be empty when used
        }
      }
    }
  }
}

# Optional: Bucket policy for log delivery permissions (recommended approach)
data "aws_iam_policy_document" "log_delivery" {
  count = var.attach_log_delivery_policy ? 1 : 0

  statement {
    sid    = "S3ServerAccessLogsPolicy"
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["logging.s3.amazonaws.com"]
    }

    actions = [
      "s3:PutObject",
    ]

    resources = [
      "${var.target_bucket_arn}/${var.target_prefix}*",
    ]

    condition {
      test     = "ArnLike"
      variable = "aws:SourceArn"
      values   = [var.source_bucket_arn]
    }

    condition {
      test     = "StringEquals"
      variable = "aws:SourceAccount"
      values   = [var.source_account_id]
    }
  }
}

resource "aws_s3_bucket_policy" "log_delivery" {
  count = var.attach_log_delivery_policy ? 1 : 0

  bucket = var.target_bucket
  policy = data.aws_iam_policy_document.log_delivery[0].json
}