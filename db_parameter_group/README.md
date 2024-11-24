# AWS DB Parameter Group Terraform Module

This module manages AWS DB Parameter Groups with customizable configurations using Terraform. It simplifies the creation, management, and tagging of DB Parameter Groups while allowing the specification of database parameters for fine-grained control.

---

## **Usage**

```hcl
module "db_parameter_group" {
  source      = "./path-to-module/db_parameter_group"
  name        = "example-db-parameter-group"
  family      = "mysql8.0"
  description = "Custom DB Parameter Group for MySQL 8.0"
  parameters = [
    {
      name         = "max_connections"
      value        = "150"
      apply_method = "immediate"
    },
    {
      name         = "slow_query_log"
      value        = "1"
      apply_method = "pending-reboot"
    }
  ]
  tags = {
    Environment = "Production"
    Team        = "DevOps"
  }
}
```

### Key Parameters in the Example

- **`name`**: The name of the DB parameter group.
- **`family`**: Specifies the database family (e.g., `mysql8.0`).
- **`parameters`**: List of parameter objects to customize database settings.
- **`tags`**: Map of tags to help identify resources.

---

## **Requirements**

| Requirement  | Version  |
| ------------ | -------- |
| Terraform    | >= 1.3.0 |
| AWS Provider | >= 5.0.0 |

---

## **Providers**

| Provider | Source    | Version  |
| -------- | --------- | -------- |
| `aws`    | HashiCorp | >= 5.0.0 |

---

## **Features**

- **Parameter Customization**: Allows dynamic configuration of database parameters.
- **Resource Protection**: Option to skip deletion during destroy operations.
- **Tagging**: Supports assigning tags for resource management.
- **Lifecycle Management**: Ensures smooth resource replacement with `create_before_destroy`.

---

## **Explanation of Files**

| File           | Description                                                             |
| -------------- | ----------------------------------------------------------------------- |
| `main.tf`      | Contains the primary resource configuration for the DB parameter group. |
| `variables.tf` | Defines input variables for the module.                                 |
| `outputs.tf`   | Declares the outputs of the module.                                     |
| `README.md`    | Documentation for the module.                                           |

---

## **Inputs**

| Name           | Type           | Default                  | Required | Description                                                            |
| -------------- | -------------- | ------------------------ | -------- | ---------------------------------------------------------------------- |
| `name`         | `string`       | `null`                   | No       | The name of the DB parameter group.                                    |
| `name_prefix`  | `string`       | `null`                   | No       | Prefix for generating a unique name if `name` is not provided.         |
| `family`       | `string`       | N/A                      | Yes      | The family of the DB parameter group.                                  |
| `description`  | `string`       | `"Managed by Terraform"` | No       | Description of the parameter group.                                    |
| `parameters`   | `list(object)` | `[]`                     | No       | List of parameters to apply, with `name`, `value`, and `apply_method`. |
| `skip_destroy` | `bool`         | `false`                  | No       | Prevents the parameter group from being deleted during destroy.        |
| `tags`         | `map(string)`  | `{}`                     | No       | Tags to assign to the resource.                                        |

---

## **Outputs**

| Name       | Description                                 |
| ---------- | ------------------------------------------- |
| `id`       | The ID of the DB parameter group.           |
| `arn`      | The ARN of the DB parameter group.          |
| `tags_all` | A map of all tags assigned to the resource. |

---

## **Example Usage**

### Example 1: MySQL DB Parameter Group

```hcl
module "mysql_db_parameter_group" {
  source      = "./path-to-module/db_parameter_group"
  name        = "mysql-db-parameter-group"
  family      = "mysql8.0"
  parameters = [
    {
      name         = "character_set_server"
      value        = "utf8mb4"
      apply_method = "immediate"
    },
    {
      name         = "default_storage_engine"
      value        = "InnoDB"
      apply_method = "immediate"
    }
  ]
  tags = {
    Project = "MySQLProject"
    Owner   = "Admin"
  }
}
```

### Example 2: PostgreSQL DB Parameter Group

```hcl
module "postgres_db_parameter_group" {
  source      = "./path-to-module/db_parameter_group"
  family      = "postgres12"
  parameters = [
    {
      name         = "log_min_duration_statement"
      value        = "1000"
      apply_method = "immediate"
    }
  ]
  skip_destroy = true
  tags = {
    Environment = "Staging"
  }
}
```

---

## **Authors**

Module maintained by [David Essien](https://davidessien.com).

---

## **License**

This project is licensed under the MIT License.
