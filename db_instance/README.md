# AWS RDS Terraform Module

This Terraform module simplifies the creation and management of an Amazon RDS instance in AWS. It abstracts the complexities of configuring an RDS instance while offering flexibility through extensive parameterization. This module supports features such as multi-AZ deployment, encryption, automated backups, and more.

---

## Usage

To use this module, include it in your Terraform configuration:

```hcl
module "rds" {
  source = "./path-to-module/db_instance"

  allocated_storage       = 20
  engine                  = "mysql"
  engine_version          = "8.0"
  instance_class          = "db.t3.micro"
  username                = "admin"
  password                = "password123"
  publicly_accessible     = false
  multi_az                = false
  backup_retention_period = 7
}
```

### Key Parameters

- **`allocated_storage`**: Specifies the amount of storage (in GiB) allocated for the RDS instance.
- **`engine`**: The database engine to use (e.g., `mysql`, `postgres`).
- **`instance_class`**: The instance type of the RDS instance (e.g., `db.t3.micro`).
- **`multi_az`**: Indicates if the instance should be deployed across multiple availability zones.
- **`backup_retention_period`**: Number of days to retain backups.

---

### Requirements

| Name         | Version   |
| ------------ | --------- |
| Terraform    | >= 1.7.5  |
| AWS Provider | >= 5.77.0 |

---

### Providers

| Provider | Source    | Version   |
| -------- | --------- | --------- |
| `aws`    | HashiCorp | >= 5.77.0 |

---

## Features

- Simplifies RDS instance setup.
- Supports multi-AZ deployments for high availability.
- Enables automated backups with customizable retention periods.
- Optionally configures database encryption.
- Allows monitoring via CloudWatch Logs.

---

## Explanation of Files

| **File**       | **Description**                                                                   |
| -------------- | --------------------------------------------------------------------------------- |
| `main.tf`      | Defines the RDS resource and its properties.                                      |
| `variables.tf` | Lists all configurable parameters with their descriptions and default values.     |
| `outputs.tf`   | Outputs the attributes of the created RDS instance, such as its endpoint and ARN. |
| `README.md`    | Provides module documentation, usage instructions, and parameter explanations.    |

---

## Inputs

| **Variable**              | **Type** | **Default** | **Description**                                                   | **Required** |
| ------------------------- | -------- | ----------- | ----------------------------------------------------------------- | ------------ |
| `allocated_storage`       | `number` |             | The allocated storage in GiB.                                     | Yes          |
| `engine`                  | `string` |             | The database engine to use (e.g., `mysql`, `postgres`).           | Yes          |
| `instance_class`          | `string` |             | The RDS instance class (e.g., `db.t3.micro`).                     | Yes          |
| `username`                | `string` |             | Username for the master DB user.                                  | Yes          |
| `password`                | `string` |             | Password for the master DB user.                                  | Yes          |
| `backup_retention_period` | `number` | `0`         | Number of days to retain backups for the instance.                | No           |
| `multi_az`                | `bool`   | `false`     | Specifies if the RDS instance is multi-AZ.                        | No           |
| `publicly_accessible`     | `bool`   | `false`     | Indicates if the instance is accessible over the public internet. | No           |
| `storage_encrypted`       | `bool`   | `false`     | Specifies if the storage is encrypted.                            | No           |

---

## Outputs

| **Output**          | **Description**                                   |
| ------------------- | ------------------------------------------------- |
| `address`           | The hostname of the RDS instance.                 |
| `arn`               | The ARN of the RDS instance.                      |
| `db_name`           | The database name.                                |
| `endpoint`          | The connection endpoint in `address:port` format. |
| `engine`            | The database engine used.                         |
| `port`              | The database port.                                |
| `status`            | The RDS instance status.                          |
| `allocated_storage` | The amount of allocated storage for the instance. |
| `multi_az`          | Indicates if the instance is multi-AZ.            |
| `username`          | The master username for the database.             |

---

## Example Usage

### Single Instance with MySQL

```hcl
module "rds" {
  source = "./path-to-module/db_instance"

  allocated_storage       = 20
  engine                  = "mysql"
  engine_version          = "8.0"
  instance_class          = "db.t3.micro"
  username                = "admin"
  password                = "securepassword"
  backup_retention_period = 7
  multi_az                = true
}
```

### PostgreSQL Instance with Multi-AZ

```hcl
module "rds" {
  source = "./path-to-module/db_instance"

  allocated_storage   = 50
  engine              = "postgres"
  engine_version      = "13"
  instance_class      = "db.m6g.large"
  username            = "pgadmin"
  password            = "anothersecurepassword"
  publicly_accessible = false
  multi_az            = true
}
```

---

## Authors

Maintained by [David Essien](https://davidessien.com).

---

## License

This project is licensed under the MIT License.
