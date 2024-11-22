# AWS RDS DB Parameter Group Module

This Terraform module manages an AWS RDS DB parameter group with support for defining parameters, lifecycle policies, and tagging.

## Features

- Supports parameter definition with `name`, `value`, and `apply_method`.
- Lifecycle management using `create_before_destroy` and `skip_destroy`.
- Tagging support for resource organization.

## Usage

```hcl
module "db_parameter_group" {
  source = "./path-to-module"

  family      = "mysql5.6"
  name_prefix = "example-pg"

  parameters = [
    {
      name         = "character_set_server"
      value        = "utf8"
      apply_method = "immediate"
    },
    {
      name         = "character_set_client"
      value        = "utf8"
    }
  ]

  tags = {
    Environment = "production"
    Team        = "devops"
  }
}
```

## Inputs

| Name                   | Type           | Default               | Description                                                                                                                                 |
|------------------------|----------------|-----------------------|---------------------------------------------------------------------------------------------------------------------------------------------|
| `name`                 | `string`       | `null`                | The name of the DB parameter group.                                                                                                        |
| `name_prefix`          | `string`       | `null`                | Creates a unique name beginning with the specified prefix. Conflicts with `name`.                                                          |
| `family`               | `string`       | n/a                   | The family of the DB parameter group.                                                                                                      |
| `description`          | `string`       | `"Managed by Terraform"` | The description of the DB parameter group.                                                                                                |
| `parameters`           | `list(object)` | `[]`                  | A list of parameters for the group, with each object containing `name`, `value`, and optional `apply_method`.                              |
| `skip_destroy`         | `bool`         | `false`               | Prevent deletion of the parameter group during destroy.                                                                                    |
| `tags`                 | `map(string)`  | `{}`                  | A map of tags to assign to the resource.                                                                                                   |
| `create_before_destroy`| `bool`         | `true`                | Whether to recreate the parameter group before destroying the old one.                                                                     |

## Outputs

| Name      | Description                          |
|-----------|--------------------------------------|
| `id`      | The ID of the DB parameter group.    |
| `arn`     | The ARN of the DB parameter group.   |
| `tags_all`| A map of all tags assigned.          |

## Examples

### Basic Usage

```hcl
module "db_parameter_group" {
  source = "./path-to-module"

  name   = "example-pg"
  family = "mysql5.6"

  parameters = [
    {
      name  = "character_set_server"
      value = "utf8"
    },
    {
      name  = "character_set_client"
      value = "utf8"
    }
  ]
}
```

### Using `create_before_destroy`

```hcl
module "db_parameter_group" {
  source = "./path-to-module"

  name_prefix = "example-pg"
  family      = "postgres13"

  parameters = [
    {
      name         = "log_connections"
      value        = "1"
      apply_method = "pending-reboot"
    }
  ]

  create_before_destroy = true
}
```

## License

This module is licensed under the MIT License. See the LICENSE file for details.
