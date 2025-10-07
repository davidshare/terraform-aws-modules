output "bucket" {
  description = "The name of the bucket with public access block applied."
  value       = aws_s3_bucket_public_access_block.this.bucket
}

output "block_public_acls" {
  description = "The effective block_public_acls setting."
  value       = aws_s3_bucket_public_access_block.this.block_public_acls
}

output "block_public_policy" {
  description = "The effective block_public_policy setting."
  value       = aws_s3_bucket_public_access_block.this.block_public_policy
}

output "ignore_public_acls" {
  description = "The effective ignore_public_acls setting."
  value       = aws_s3_bucket_public_access_block.this.ignore_public_acls
}

output "restrict_public_buckets" {
  description = "The effective restrict_public_buckets setting."
  value       = aws_s3_bucket_public_access_block.this.restrict_public_buckets
}