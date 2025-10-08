resource "aws_s3_bucket_accelerate_configuration" "this" {
  bucket = var.bucket
  status = var.status

  # Use a conditional to set the expected_bucket_owner only if it is provided
  expected_bucket_owner = var.expected_bucket_owner != null ? var.expected_bucket_owner : null
}