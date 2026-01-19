# AWS Terraform Module: ECS Cluster

This Terraform module provisions an **AWS ECS Cluster**, exposing **all supported configuration options** for the `aws_ecs_cluster` resource.
It supports execute command configuration, managed storage encryption, Service Connect defaults, and cluster-level settings such as CloudWatch Container Insights.

This module is intentionally **low-level and unopinionated**, making it suitable as a foundation for higher-level ECS service or Fargate modules.

---

## Usage

### Basic Example

```hcl
module "ecs_cluster" {
  source = "./path/to/ecs-cluster"

  name = "my-ecs-cluster"

  tags = {
    Environment = "Production"
    Owner       = "Platform Team"
  }
}
```

---

### Enable Container Insights

```hcl
module "ecs_cluster" {
  source = "./path/to/ecs-cluster"

  name = "observability-cluster"

  settings = [
    {
      name  = "containerInsights"
      value = "enabled"
    }
  ]
}
```

---

### Execute Command with Override Logging

```hcl
module "ecs_cluster" {
  source = "./path/to/ecs-cluster"

  name = "exec-cluster"

  configuration = {
    execute_command_configuration = {
      logging    = "OVERRIDE"
      kms_key_id = aws_kms_key.example.arn

      log_configuration = {
        cloud_watch_log_group_name     = aws_cloudwatch_log_group.example.name
        cloud_watch_encryption_enabled = true
      }
    }
  }
}
```

---

### Fargate Ephemeral Storage with Customer-Managed KMS

```hcl
module "ecs_cluster" {
  source = "./path/to/ecs-cluster"

  name = "fargate-secure-cluster"

  configuration = {
    managed_storage_configuration = {
      fargate_ephemeral_storage_kms_key_id = aws_kms_key.example.arn
    }
  }
}
```

---

## Key Parameters

- `name`: Name of the ECS cluster.
- `settings`: Cluster-level settings such as Container Insights.
- `configuration`: Cluster configuration including execute command and managed storage.
- `service_connect_defaults`: Default Service Connect namespace for services created in the cluster.
- `tags`: Tags applied to the ECS cluster.

---

## Requirements

| Name         | Version   |
| ------------ | --------- |
| Terraform    | >= 1.7.5  |
| AWS Provider | >= 5.77.0 |

---

## Providers

| Provider | Source    | Version   |
| -------- | --------- | --------- |
| `aws`    | HashiCorp | >= 5.77.0 |

---

## Features

- Creates an ECS cluster.
- Supports Execute Command configuration.
- Supports CloudWatch and S3 logging for exec sessions.
- Supports Fargate ephemeral storage encryption.
- Supports Service Connect defaults.
- Supports CloudWatch Container Insights.
- Flexible tagging support.
- Fully optional nested configuration blocks.

---

## Explanation of Files

| File           | Description                          |
| -------------- | ------------------------------------ |
| `main.tf`      | Defines the ECS cluster resource.    |
| `variables.tf` | Declares all module input variables. |
| `outputs.tf`   | Exposes ECS cluster attributes.      |
| `README.md`    | Documentation for the module.        |

---

## Inputs

| Variable                   | Description                       | Type           | Default | Required |
| -------------------------- | --------------------------------- | -------------- | ------- | -------- |
| `name`                     | ECS cluster name                  | `string`       | –       | Yes      |
| `region`                   | AWS region for the cluster        | `string`       | `null`  | No       |
| `tags`                     | Tags applied to the cluster       | `map(string)`  | `{}`    | No       |
| `settings`                 | ECS cluster settings              | `list(object)` | `[]`    | No       |
| `service_connect_defaults` | Default Service Connect namespace | `object`       | `null`  | No       |
| `configuration`            | Cluster configuration             | `object`       | `null`  | No       |

---

## Outputs

| Output     | Description                     |
| ---------- | ------------------------------- |
| `id`       | ID of the ECS cluster           |
| `arn`      | ARN of the ECS cluster          |
| `name`     | Name of the ECS cluster         |
| `tags_all` | All tags applied to the cluster |

---

## Import

Terraform v1.5+ supports import blocks:

```hcl
import {
  to = aws_ecs_cluster.this
  id = "my-ecs-cluster"
}
```

Or via CLI:

```bash
terraform import aws_ecs_cluster.this my-ecs-cluster
```

---

## Authors

Module is maintained by **David Essien**.

---

## License

This project is licensed under the **MIT License**. See `LICENSE` for details.
