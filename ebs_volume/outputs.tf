output "volume_id" {
  description = "The volume ID"
  value       = aws_ebs_volume.this.id
}

output "volume_arn" {
  description = "The volume ARN"
  value       = aws_ebs_volume.this.arn
}