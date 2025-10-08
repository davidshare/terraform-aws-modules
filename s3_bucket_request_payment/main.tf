resource "aws_s3_bucket_request_payment_configuration" "this" {
  bucket = var.bucket
  payer  = var.payer

  expected_bucket_owner = var.expected_bucket_owner
}