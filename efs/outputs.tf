output "file_system_id" {
  description = "The ID that identifies the file system"
  value       = aws_efs_file_system.this.id
}

output "file_system_arn" {
  description = "The ARN of the file system"
  value       = aws_efs_file_system.this.arn
}

output "mount_targets" {
  description = "List of mount target IDs"
  value       = aws_efs_mount_target.this[*].id
}