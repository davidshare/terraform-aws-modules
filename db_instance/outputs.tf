output "address" {
  description = "The hostname of the RDS instance"
  value       = aws_db_instance.this.address
}

output "arn" {
  description = "The ARN of the RDS instance"
  value       = aws_db_instance.this.arn
}

output "allocated_storage" {
  description = "The amount of allocated storage"
  value       = aws_db_instance.this.allocated_storage
}

output "availability_zone" {
  description = "The availability zone of the instance"
  value       = aws_db_instance.this.availability_zone
}

output "backup_retention_period" {
  description = "The backup retention period"
  value       = aws_db_instance.this.backup_retention_period
}

output "backup_window" {
  description = "The backup window"
  value       = aws_db_instance.this.backup_window
}

output "ca_cert_identifier" {
  description = "Identifier of the CA certificate for the DB instance"
  value       = aws_db_instance.this.ca_cert_identifier
}

output "db_name" {
  description = "The database name"
  value       = aws_db_instance.this.db_name
}

output "domain" {
  description = "The ID of the Directory Service Active Directory domain the instance is joined to"
  value       = aws_db_instance.this.domain
}

output "endpoint" {
  description = "The connection endpoint in address:port format"
  value       = aws_db_instance.this.endpoint
}

output "engine" {
  description = "The database engine"
  value       = aws_db_instance.this.engine
}

output "engine_version_actual" {
  description = "The running version of the database"
  value       = aws_db_instance.this.engine_version_actual
}

output "hosted_zone_id" {
  description = "The canonical hosted zone ID of the DB instance (to be used in a Route 53 Alias record)"
  value       = aws_db_instance.this.hosted_zone_id
}

output "id" {
  description = "The RDS instance ID"
  value       = aws_db_instance.this.id
}

output "instance_class" {
  description = "The RDS instance class"
  value       = aws_db_instance.this.instance_class
}

output "latest_restorable_time" {
  description = "The latest time, in UTC RFC3339 format, to which a database can be restored with point-in-time restore"
  value       = aws_db_instance.this.latest_restorable_time
}

output "maintenance_window" {
  description = "The instance maintenance window"
  value       = aws_db_instance.this.maintenance_window
}

output "multi_az" {
  description = "If the RDS instance is multi AZ enabled"
  value       = aws_db_instance.this.multi_az
}

output "port" {
  description = "The database port"
  value       = aws_db_instance.this.port
}

output "resource_id" {
  description = "The RDS Resource ID of this instance"
  value       = aws_db_instance.this.resource_id
}

output "status" {
  description = "The RDS instance status"
  value       = aws_db_instance.this.status
}

output "storage_encrypted" {
  description = "Whether the DB instance is encrypted"
  value       = aws_db_instance.this.storage_encrypted
}

output "username" {
  description = "The master username for the database"
  value       = aws_db_instance.this.username
}
