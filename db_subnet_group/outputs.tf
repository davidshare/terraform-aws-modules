output "db_subnet_group_id" {
  description = "The ID of the DB subnet group."
  value       = aws_db_subnet_group.this.id
}

output "db_subnet_group_arn" {
  description = "The ARN of the DB subnet group."
  value       = aws_db_subnet_group.this.arn
}

output "name" {
  description = "The name of the DB subnet group."
  value       = aws_db_subnet_group.this.name
}

output "supported_network_types" {
  description = "The network types supported by the DB subnet group."
  value       = aws_db_subnet_group.this.supported_network_types
}

output "vpc_id" {
  description = "The VPC ID associated with the DB subnet group."
  value       = aws_db_subnet_group.this.vpc_id
}

output "tags_all" {
  description = "A map of all tags assigned to the DB subnet group, including inherited ones."
  value       = aws_db_subnet_group.this.tags_all
}
