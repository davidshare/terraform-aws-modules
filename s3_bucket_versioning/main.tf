resource "aws_s3_bucket_versioning" "this" {
  bucket                = var.bucket
  expected_bucket_owner = var.expected_bucket_owner
  mfa                   = var.mfa

  versioning_configuration {
    status     = var.versioning_configuration.status
    mfa_delete = var.versioning_configuration.mfa_delete
  }
}