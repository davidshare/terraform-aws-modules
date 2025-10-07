output "id" {
  description = "The ID of the DB parameter group."
  value       = aws_db_parameter_group.this.id
}

output "arn" {
  description = "The ARN of the DB parameter group."
  value       = aws_db_parameter_group.this.arn
}

output "tags_all" {
  description = "A map of all tags assigned to the DB parameter group."
  value       = aws_db_parameter_group.this.tags_all
}
