# AWS RDS DB Instance Module

This Terraform module manages an **AWS RDS DB Instance**. It supports a wide variety of configurations for both standard and advanced use cases, including:

- Support for different database engines (`MySQL`, `PostgreSQL`, `MariaDB`, etc.).
- Multi-AZ deployment.
- Optional configurations such as **restore-to-point-in-time**, **S3 import**, and **serverless v2 scaling**.
- Flexible IAM, networking, monitoring, and backup options.

---

## **Usage**

### Basic Example

```hcl
module "db_instance" {
  source = "./modules/aws_db_instance"

  allocated_storage = 20
  engine            = "mysql"
  engine_version    = "8.0"
  instance_class    = "db.t3.micro"
  username          = "admin"
  password          = "securepassword123"
  publicly_accessible = false

  vpc_security_group_ids = ["sg-0123456789abcdef0"]
  db_subnet_group_name   = "my-db-subnet-group"

  tags = {
    Environment = "production"
    Project     = "my-project"
  }
}
```

### Advanced Example: Restore to Point in Time

```hcl
module "db_instance" {
  source = "./modules/aws_db_instance"

  restore_to_point_in_time = {
    source_db_instance_identifier = "my-source-db"
    use_latest_restorable_time    = true
    restore_time                  = null
    db_instance_identifier        = "restored-db"
  }

  instance_class              = "db.t3.medium"
  multi_az                    = true
  backup_retention_period     = 7
  enabled_cloudwatch_logs_exports = ["error", "general", "slowquery"]

  tags = {
    Name = "restored-db-instance"
  }
}
```

---

## **Inputs**

The module accepts the following inputs. Refer to `variables.tf` for detailed descriptions.

| Name                                  | Type           | Default | Description                                                      |
| ------------------------------------- | -------------- | ------- | ---------------------------------------------------------------- |
| `allocated_storage`                   | `number`       | -       | Amount of allocated storage in GB.                               |
| `auto_minor_version_upgrade`          | `bool`         | `true`  | Automatically apply minor engine upgrades.                       |
| `availability_zone`                   | `string`       | `null`  | The availability zone for the instance.                          |
| `backup_retention_period`             | `number`       | `7`     | Number of days to retain backups.                                |
| `backup_window`                       | `string`       | `null`  | Preferred backup window.                                         |
| `ca_cert_identifier`                  | `string`       | `null`  | The CA certificate identifier.                                   |
| `db_name`                             | `string`       | `null`  | Name of the database to create.                                  |
| `db_subnet_group_name`                | `string`       | `null`  | Name of the subnet group for the DB instance.                    |
| `deletion_protection`                 | `bool`         | `false` | Prevent the instance from being deleted.                         |
| `domain`                              | `string`       | `null`  | Active Directory domain to join.                                 |
| `domain_auth_secret_arn`              | `string`       | `null`  | ARN of the Secrets Manager secret with AD credentials.           |
| `domain_dns_ips`                      | `list(string)` | `null`  | IP addresses of DNS servers for the AD domain.                   |
| `domain_fqdn`                         | `string`       | `null`  | Fully qualified domain name for the AD domain.                   |
| `domain_iam_role_name`                | `string`       | `null`  | IAM role for authenticating with the AD domain.                  |
| `engine`                              | `string`       | -       | The database engine to use (e.g., `mysql`, `postgres`).          |
| `engine_version`                      | `string`       | -       | The version of the database engine.                              |
| `final_snapshot_identifier`           | `string`       | `null`  | Identifier for the final snapshot before deletion.               |
| `instance_class`                      | `string`       | -       | The instance type for the DB instance (e.g., `db.t3.micro`).     |
| `multi_az`                            | `bool`         | `false` | Enable Multi-AZ deployment.                                      |
| `password`                            | `string`       | -       | Master user password.                                            |
| `performance_insights_enabled`        | `bool`         | `false` | Enable Performance Insights.                                     |
| `replicate_source_db`                 | `string`       | `null`  | The identifier of the source DB for replication.                 |
| `restore_to_point_in_time`            | `object`       | `null`  | Restore configuration for a specific point in time.              |
| `s3_import`                           | `object`       | `null`  | S3 import configuration for the database.                        |
| `serverless_v2_scaling_configuration` | `object`       | `null`  | Scaling configuration for serverless DB instances.               |
| `timeouts`                            | `object`       | `{...}` | Timeout configuration for create, update, and delete operations. |
| `vpc_security_group_ids`              | `list(string)` | `[]`    | List of VPC security group IDs.                                  |

---

## **Outputs**

The module exports the following outputs:

| Name                     | Description                            |
| ------------------------ | -------------------------------------- |
| `db_instance_arn`        | The ARN of the DB instance.            |
| `db_instance_address`    | The address of the DB instance.        |
| `db_instance_status`     | The current status of the DB instance. |
| `db_instance_identifier` | The identifier of the DB instance.     |

---

## **Advanced Features**

### Restore to Point in Time

This feature allows restoring an RDS DB instance to a specific point in time, using the `restore_to_point_in_time` block. Example:

```hcl
restore_to_point_in_time = {
  source_db_instance_identifier = "my-source-db"
  use_latest_restorable_time    = true
  restore_time                  = null
  db_instance_identifier        = "restored-db"
}
```

### S3 Import

Import data from S3 into an RDS DB instance with the `s3_import` block. Example:

```hcl
s3_import = {
  bucket_name          = "my-bucket"
  bucket_prefix        = "db-backups/"
  ingestion_role       = "arn:aws:iam::123456789012:role/S3IngestionRole"
  source_engine        = "mysql"
  source_engine_version = "8.0"
}
```

### Serverless v2 Scaling

Use serverless v2 scaling for Aurora DB instances:

```hcl
serverless_v2_scaling_configuration = {
  min_capacity = 0.5
  max_capacity = 2.0
}
```

---

## **Notes**

- Ensure the `engine` and `engine_version` are compatible with your use case.
- Use secure practices for storing sensitive values like `password` (e.g., Secrets Manager).
- For Multi-AZ deployments, additional costs may apply.

---

## **Author**

This module is maintained by [Your Name or Organization]. Contributions and issues are welcome.

Let me know if you'd like further customization!
