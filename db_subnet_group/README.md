# Terraform Module: AWS DB Subnet Group

This Terraform module creates an **AWS DB Subnet Group**.

## Example Usage

```hcl
module "db_subnet_group" {
  source      = "./path-to-module"
  name        = "example-db-subnet-group"
  name_prefix = null
  description = "DB Subnet Group for RDS"
  subnet_ids  = ["subnet-0123456789abcdef0", "subnet-0abcdef1234567890"]
  tags = {
    Environment = "production"
    Project     = "example-project"
  }
}
```

## Resource: `aws_db_subnet_group`

Provides an RDS DB subnet group resource.

### Argument Reference

| Name          | Description                                                                               | Type           | Default                  | Required |
| ------------- | ----------------------------------------------------------------------------------------- | -------------- | ------------------------ | -------- |
| `name`        | The name of the DB subnet group. If omitted, Terraform will assign a random, unique name. | `string`       | `null`                   | No       |
| `name_prefix` | Creates a unique name beginning with the specified prefix. Conflicts with `name`.         | `string`       | `null`                   | No       |
| `description` | The description of the DB subnet group. Defaults to "Managed by Terraform".               | `string`       | `"Managed by Terraform"` | No       |
| `subnet_ids`  | A list of VPC subnet IDs.                                                                 | `list(string)` | n/a                      | Yes      |
| `tags`        | A map of tags to assign to the resource.                                                  | `map(string)`  | `{}`                     | No       |

### Attribute Reference

This resource exports the following attributes:

- **`id`**: The name of the DB subnet group.
- **`arn`**: The ARN of the DB subnet group.
- **`supported_network_types`**: The network type of the DB subnet group.
- **`tags_all`**: A map of tags assigned to the resource, including inherited ones.
- **`vpc_id`**: The VPC ID of the DB subnet group.

## Inputs

| Name          | Description                                                                               | Type           | Default                  | Required |
| ------------- | ----------------------------------------------------------------------------------------- | -------------- | ------------------------ | -------- |
| `name`        | The name of the DB subnet group. If omitted, Terraform will assign a random, unique name. | `string`       | `null`                   | No       |
| `name_prefix` | Creates a unique name beginning with the specified prefix. Conflicts with `name`.         | `string`       | `null`                   | No       |
| `description` | The description of the DB subnet group. Defaults to "Managed by Terraform".               | `string`       | `"Managed by Terraform"` | No       |
| `subnet_ids`  | A list of VPC subnet IDs.                                                                 | `list(string)` | n/a                      | Yes      |
| `tags`        | A map of tags to assign to the resource.                                                  | `map(string)`  | `{}`                     | No       |

## Outputs

| Name                      | Description                                         |
| ------------------------- | --------------------------------------------------- |
| `db_subnet_group_id`      | The ID of the DB subnet group.                      |
| `db_subnet_group_arn`     | The ARN of the DB subnet group.                     |
| `supported_network_types` | The network types supported by the DB subnet group. |
| `vpc_id`                  | The VPC ID associated with the DB subnet group.     |
| `tags_all`                | All tags assigned to the DB subnet group.           |

## Requirements

- Terraform 1.0+
- AWS Provider 3.0+

## License

MIT
