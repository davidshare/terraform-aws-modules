# AWS DB Subnet Group Terraform Module

This module manages AWS DB Subnet Groups with Terraform. It helps to group subnets for Amazon RDS, ensuring proper isolation and accessibility for database instances within a Virtual Private Cloud (VPC).

---

## **Usage**

```hcl
module "db_subnet_group" {
  source      = "./path-to-module/db_subnet_group"
  name        = "example-db-subnet-group"
  description = "Custom DB Subnet Group for My Application"
  subnet_ids  = ["subnet-12345abc", "subnet-67890def"]
  tags = {
    Environment = "Production"
    Project     = "MyApp"
  }
}
```

### Key Parameters in the Example

- **`name`**: The name of the DB subnet group.
- **`description`**: A user-defined description for the subnet group.
- **`subnet_ids`**: List of VPC subnet IDs to include in the subnet group.
- **`tags`**: A map of tags for resource identification.

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

- **Subnet Group Management**: Easily group subnets for Amazon RDS instances.
- **Tagging**: Supports tagging for resource tracking and management.
- **Custom Naming**: Allows custom names or auto-generated unique names.

---

## **Explanation of Files**

| File           | Description                                                          |
| -------------- | -------------------------------------------------------------------- |
| `main.tf`      | Contains the primary resource configuration for the DB subnet group. |
| `variables.tf` | Defines input variables for the module.                              |
| `outputs.tf`   | Declares the outputs of the module.                                  |
| `README.md`    | Documentation for the module.                                        |

---

## **Inputs**

| Name          | Type           | Default                  | Required | Description                                                    |
| ------------- | -------------- | ------------------------ | -------- | -------------------------------------------------------------- |
| `name`        | `string`       | `null`                   | No       | The name of the DB subnet group.                               |
| `name_prefix` | `string`       | `null`                   | No       | Prefix for generating a unique name if `name` is not provided. |
| `description` | `string`       | `"Managed by Terraform"` | No       | Description of the subnet group.                               |
| `subnet_ids`  | `list(string)` | N/A                      | Yes      | List of VPC subnet IDs to include in the subnet group.         |
| `tags`        | `map(string)`  | `{}`                     | No       | A map of tags to assign to the resource.                       |

---

## **Outputs**

| Name                      | Description                                                                  |
| ------------------------- | ---------------------------------------------------------------------------- |
| `id`      | The ID of the DB subnet group.                                               |
| `arn`     | The ARN of the DB subnet group.                                              |
| `name`                    | The name of the DB subnet group.                                             |
| `supported_network_types` | The network types supported by the DB subnet group.                          |
| `vpc_id`                  | The VPC ID associated with the DB subnet group.                              |
| `tags_all`                | A map of all tags assigned to the DB subnet group, including inherited ones. |

---

## **Example Usage**

### Example 1: Subnet Group for Production Environment

```hcl
module "production_db_subnet_group" {
  source      = "./path-to-module/db_subnet_group"
  name        = "prod-db-subnet-group"
  description = "Subnet Group for Production DB"
  subnet_ids  = ["subnet-1a2b3c4d", "subnet-5e6f7g8h"]
  tags = {
    Environment = "Production"
    Owner       = "DBTeam"
  }
}
```

### Example 2: Subnet Group with Auto-Generated Name

```hcl
module "auto_name_db_subnet_group" {
  source       = "./path-to-module/db_subnet_group"
  name_prefix  = "auto-db-subnet"
  subnet_ids   = ["subnet-a1b2c3d4", "subnet-e5f6g7h8"]
  description  = "Auto-generated DB Subnet Group"
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
