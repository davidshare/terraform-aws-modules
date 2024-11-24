output "id" {
  description = "The volume ID"
  value       = aws_ebs_volume.this.id
}

output "arn" {
  description = "The volume ARN"
  value       = aws_ebs_volume.this.arn
}