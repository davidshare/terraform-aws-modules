variable "allocated_storage" {
  description = "The allocated storage in gibibytes"
  type        = number
}

variable "allow_major_version_upgrade" {
  description = "Indicates that major version upgrades are allowed"
  type        = bool
  default     = false
}

variable "apply_immediately" {
  description = "Specifies whether any database modifications are applied immediately, or during the next maintenance window"
  type        = bool
  default     = false
}

variable "auto_minor_version_upgrade" {
  description = "Indicates that minor engine upgrades will be applied automatically to the DB instance during the maintenance window"
  type        = bool
  default     = true
}

variable "availability_zone" {
  description = "The AZ for the RDS instance"
  type        = string
  default     = null
}

variable "backup_retention_period" {
  description = "The days to retain backups for"
  type        = number
  default     = 0
}

variable "backup_target" {
  description = "Specifies where automated backups and manual snapshots are stored"
  type        = string
  default     = null
}

variable "backup_window" {
  description = "The daily time range during which automated backups are created if automated backups are enabled"
  type        = string
  default     = null
}

variable "blue_green_update_enabled" {
  description = "Enables low-downtime updates using RDS Blue/Green deployments"
  type        = bool
  default     = false
}

variable "ca_cert_identifier" {
  description = "The identifier of the CA certificate for the DB instance"
  type        = string
  default     = null
}

variable "character_set_name" {
  description = "The character set name to use for DB encoding in Oracle and Microsoft SQL instances"
  type        = string
  default     = null
}

variable "copy_tags_to_snapshot" {
  description = "Copy all Instance tags to snapshots"
  type        = bool
  default     = false
}

variable "custom_iam_instance_profile" {
  description = "The instance profile associated with the underlying Amazon EC2 instance of an RDS Custom DB instance"
  type        = string
  default     = null
}

variable "db_name" {
  description = "The name of the database to create when the DB instance is created"
  type        = string
  default     = null
}

variable "db_subnet_group_name" {
  description = "Name of DB subnet group"
  type        = string
  default     = null
}

variable "dedicated_log_volume" {
  description = "Use a dedicated log volume (DLV) for the DB instance"
  type        = bool
  default     = false
}

variable "delete_automated_backups" {
  description = "Specifies whether to remove automated backups immediately after the DB instance is deleted"
  type        = bool
  default     = true
}

variable "deletion_protection" {
  description = "If the DB instance should have deletion protection enabled"
  type        = bool
  default     = false
}

variable "domain" {
  description = "The ID of the Directory Service Active Directory domain to create the instance in"
  type        = string
  default     = null
}

variable "domain_auth_secret_arn" {
  description = "The ARN for the Secrets Manager secret with the self managed Active Directory credentials"
  type        = string
  default     = null
}

variable "domain_dns_ips" {
  description = "The IPv4 DNS IP addresses of your primary and secondary self managed Active Directory domain controllers"
  type        = list(string)
  default     = null
}

variable "domain_fqdn" {
  description = "The fully qualified domain name (FQDN) of the self managed Active Directory domain"
  type        = string
  default     = null
}

variable "domain_iam_role_name" {
  description = "The name of the IAM role to be used when making API calls to the Directory Service"
  type        = string
  default     = null
}

variable "domain_ou" {
  description = "The self managed Active Directory organizational unit for your DB instance to join"
  type        = string
  default     = null
}

variable "enabled_cloudwatch_logs_exports" {
  description = "Set of log types to enable for exporting to CloudWatch logs"
  type        = list(string)
  default     = []
}

variable "engine" {
  description = "The database engine to use"
  type        = string
}

variable "engine_version" {
  description = "The engine version to use"
  type        = string
}

variable "engine_lifecycle_support" {
  description = "The life cycle type for this DB instance"
  type        = string
  default     = "open-source-rds-extended-support"
}

variable "final_snapshot_identifier" {
  description = "The name of your final DB snapshot when this DB instance is deleted"
  type        = string
  default     = null
}

variable "iam_database_authentication_enabled" {
  description = "Specifies whether mappings of AWS Identity and Access Management (IAM) accounts to database accounts is enabled"
  type        = bool
  default     = false
}

variable "identifier" {
  description = "The name of the RDS instance"
  type        = string
  default     = null
}

variable "identifier_prefix" {
  description = "Creates a unique identifier beginning with the specified prefix"
  type        = string
  default     = null
}

variable "instance_class" {
  description = "The instance type of the RDS instance"
  type        = string
}

variable "iops" {
  description = "The amount of provisioned IOPS"
  type        = number
  default     = null
}

variable "kms_key_id" {
  description = "The ARN for the KMS encryption key"
  type        = string
  default     = null
}

variable "license_model" {
  description = "License model information for this DB instance"
  type        = string
  default     = null
}

variable "maintenance_window" {
  description = "The window to perform maintenance in"
  type        = string
  default     = null
}

variable "manage_master_user_password" {
  description = "Set to true to allow RDS to manage the master user password in Secrets Manager"
  type        = bool
  default     = false
}

variable "master_user_secret_kms_key_id" {
  description = "The Amazon Web Services KMS key identifier for encrypting the master user password secret"
  type        = string
  default     = null
}

variable "max_allocated_storage" {
  description = "When configured, the upper limit to which Amazon RDS can automatically scale the storage of the DB instance"
  type        = number
  default     = 0
}

variable "monitoring_interval" {
  description = "The interval, in seconds, between points when Enhanced Monitoring metrics are collected for the DB instance"
  type        = number
  default     = 0
}

variable "monitoring_role_arn" {
  description = "The ARN for the IAM role that permits RDS to send enhanced monitoring metrics to CloudWatch Logs"
  type        = string
  default     = null
}

variable "multi_az" {
  description = "Specifies if the RDS instance is multi-AZ"
  type        = bool
  default     = false
}

variable "nchar_character_set_name" {
  description = "The national character set for the DB instance"
  type        = string
  default     = null
}

variable "network_type" {
  description = "The network type of the DB instance"
  type        = string
  default     = null
}

variable "option_group_name" {
  description = "Name of the DB option group to associate"
  type        = string
  default     = null
}

variable "parameter_group_name" {
  description = "Name of the DB parameter group to associate"
  type        = string
  default     = null
}

variable "password" {
  description = "Password for the master DB user"
  type        = string
  default     = null
}

variable "performance_insights_enabled" {
  description = "Specifies whether Performance Insights are enabled"
  type        = bool
  default     = false
}

variable "performance_insights_kms_key_id" {
  description = "The ARN for the KMS key to encrypt Performance Insights data"
  type        = string
  default     = null
}

variable "performance_insights_retention_period" {
  description = "Amount of time in days to retain Performance Insights data"
  type        = number
  default     = 7
}

variable "port" {
  description = "The port on which the DB accepts connections"
  type        = number
  default     = null
}

variable "publicly_accessible" {
  description = "Bool to control if instance is publicly accessible"
  type        = bool
  default     = false
}

variable "replica_mode" {
  description = "Specifies whether the replica is in either mounted or open-read-only mode"
  type        = string
  default     = null
}

variable "replicate_source_db" {
  description = "Specifies that this resource is a Replicate database, and to use this value as the source database"
  type        = string
  default     = null
}

variable "upgrade_storage_config" {
  description = "Whether to upgrade the storage file system configuration on the read replica"
  type        = bool
  default     = false
}

variable "restore_to_point_in_time" {
  description = "A configuration block for restoring a DB instance to an arbitrary point in time"
  type = object({
    restore_time                             = optional(string)
    source_db_instance_identifier            = optional(string)
    source_db_instance_automated_backups_arn = optional(string)
    source_dbi_resource_id                   = optional(string)
    use_latest_restorable_time               = optional(bool)
  })
  default = null
}

variable "s3_import" {
  description = "Configuration block for S3 import"
  type = object({
    source_engine         = string
    source_engine_version = string
    bucket_name           = string
    bucket_prefix         = optional(string)
    ingestion_role        = string
  })
  default = null
}

variable "skip_final_snapshot" {
  description = "Determines whether a final DB snapshot is created before the DB instance is deleted"
  type        = bool
  default     = false
}

variable "snapshot_identifier" {
  description = "Specifies whether or not to create this database from a snapshot"
  type        = string
  default     = null
}

variable "storage_encrypted" {
  description = "Specifies whether the DB instance is encrypted"
  type        = bool
  default     = false
}

variable "storage_type" {
  description = "One of 'standard' (magnetic), 'gp2' (general purpose SSD), 'gp3' (general purpose SSD that needs iops independently) or 'io1' (provisioned IOPS SSD)"
  type        = string
  default     = "gp2"
}

variable "storage_throughput" {
  description = "The storage throughput value for the DB instance"
  type        = number
  default     = null
}

variable "tags" {
  description = "A map of tags to assign to the resource"
  type        = map(string)
  default     = {}
}

variable "timezone" {
  description = "Time zone of the DB instance"
  type        = string
  default     = null
}

variable "username" {
  description = "Username for the master DB user"
  type        = string
  default     = null
}

variable "vpc_security_group_ids" {
  description = "List of VPC security groups to associate"
  type        = list(string)
  default     = []
}

variable "customer_owned_ip_enabled" {
  description = "Indicates whether to enable a customer-owned IP address (CoIP) for an RDS on Outposts DB instance"
  type        = bool
  default     = false
}

variable "listener_endpoint" {
  description = "Configuration block for listener endpoint"
  type = object({
    port                    = number
    vpc_security_group_ids  = list(string)
  })
  default = null
}

variable "timeouts" {
  description = "A configuration block for DB instance timeouts"
  type = object({
    create = optional(string)
    delete = optional(string)
    update = optional(string)
  })
  default = null
}

