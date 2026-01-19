# AWS Terraform Module: ECS Task Definition

This Terraform module provisions an **AWS ECS Task Definition**, managing a single revision of a task definition that can be consumed by `aws_ecs_service` or standalone ECS tasks.

The module exposes **all supported arguments** of the `aws_ecs_task_definition` resource, including advanced configurations such as:

- Fargate and EC2 compatibility
- Runtime platform (OS family & CPU architecture)
- App Mesh proxy configuration
- Docker, EFS, and FSx volume types
- Placement constraints
- Ephemeral storage
- Fault injection

This module is intentionally **low-level and unopinionated**, making it suitable as a **foundational building block** for higher-level ECS service or Fargate modules.

---

## Usage

### Basic Example

```hcl
module "ecs_task_definition" {
  source = "./path/to/ecs-task-definition"

  family                = "service"
  container_definitions = file("task-definitions/service.json")
}
```

---

### Fargate Task Definition

```hcl
module "ecs_task_definition" {
  source = "./path/to/ecs-task-definition"

  family                   = "fargate-task"
  container_definitions    = file("task-definitions/fargate.json")
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  cpu                      = "1024"
  memory                   = "2048"

  runtime_platform = {
    operating_system_family = "LINUX"
    cpu_architecture        = "X86_64"
  }
}
```

---

### Task Definition with App Mesh Proxy

```hcl
module "ecs_task_definition" {
  source = "./path/to/ecs-task-definition"

  family                = "appmesh-task"
  container_definitions = file("task-definitions/appmesh.json")

  proxy_configuration = {
    type           = "APPMESH"
    container_name = "envoy"
    properties = {
      AppPorts         = "8080"
      ProxyIngressPort = "15000"
      ProxyEgressPort  = "15001"
      IgnoredUID       = "1337"
    }
  }
}
```

---

### Task Definition with EFS Volume

```hcl
module "ecs_task_definition" {
  source = "./path/to/ecs-task-definition"

  family                = "efs-task"
  container_definitions = file("task-definitions/efs.json")

  volumes = [
    {
      name = "efs-storage"

      efs_volume_configuration = {
        file_system_id     = aws_efs_file_system.example.id
        transit_encryption = "ENABLED"

        authorization_config = {
          access_point_id = aws_efs_access_point.example.id
          iam             = "ENABLED"
        }
      }
    }
  ]
}
```

---

## Key Parameters

- `family`: Unique name for the task definition family.
- `container_definitions`: JSON document defining container configurations.
- `cpu` / `memory`: Required for Fargate tasks.
- `requires_compatibilities`: Launch types (`EC2`, `FARGATE`, etc.).
- `network_mode`: Docker networking mode.
- `runtime_platform`: Operating system family and CPU architecture.
- `volumes`: Docker, EFS, or FSx volume configurations.
- `proxy_configuration`: App Mesh proxy settings.
- `ephemeral_storage`: Expanded ephemeral storage for Fargate tasks.
- `placement_constraints`: Rules for task placement.
- `tags`: Resource tags.

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

- Creates an ECS Task Definition revision.
- Supports EC2, Fargate, EXTERNAL, and MANAGED_INSTANCES launch types.
- Supports runtime platform configuration (Linux/Windows, x86_64/ARM64).
- Supports App Mesh proxy configuration.
- Supports Docker volumes, Amazon EFS, and Amazon FSx Windows File Server.
- Supports placement constraints and fault injection.
- Supports expanded ephemeral storage for Fargate tasks.
- Flexible tagging support.
- Fully optional and repeatable configuration blocks.

---

## Explanation of Files

| File           | Description                               |
| -------------- | ----------------------------------------- |
| `main.tf`      | Defines the ECS task definition resource. |
| `variables.tf` | Declares all supported input variables.   |
| `outputs.tf`   | Exposes task definition attributes.       |
| `README.md`    | Documentation for the module.             |

---

## Inputs

| Variable                   | Description                        | Type           | Default | Required |
| -------------------------- | ---------------------------------- | -------------- | ------- | -------- |
| `family`                   | Task definition family name        | `string`       | –       | Yes      |
| `container_definitions`    | JSON container definition document | `string`       | –       | Yes      |
| `region`                   | AWS region override                | `string`       | `null`  | No       |
| `cpu`                      | CPU units for the task             | `string`       | `null`  | No       |
| `memory`                   | Memory (MiB) for the task          | `string`       | `null`  | No       |
| `network_mode`             | Docker network mode                | `string`       | `null`  | No       |
| `ipc_mode`                 | IPC namespace mode                 | `string`       | `null`  | No       |
| `pid_mode`                 | PID namespace mode                 | `string`       | `null`  | No       |
| `execution_role_arn`       | IAM role for ECS agent             | `string`       | `null`  | No       |
| `task_role_arn`            | IAM role assumed by task           | `string`       | `null`  | No       |
| `requires_compatibilities` | Launch types                       | `set(string)`  | `null`  | No       |
| `runtime_platform`         | OS family and CPU architecture     | `object`       | `null`  | No       |
| `proxy_configuration`      | App Mesh proxy config              | `object`       | `null`  | No       |
| `ephemeral_storage`        | Fargate ephemeral storage          | `object`       | `null`  | No       |
| `placement_constraints`    | Task placement rules               | `list(object)` | `[]`    | No       |
| `volumes`                  | Task volumes                       | `list(object)` | `[]`    | No       |
| `enable_fault_injection`   | Enable fault injection             | `bool`         | `false` | No       |
| `skip_destroy`             | Retain old revision on destroy     | `bool`         | `false` | No       |
| `track_latest`             | Track latest ACTIVE revision       | `bool`         | `false` | No       |
| `tags`                     | Resource tags                      | `map(string)`  | `{}`    | No       |

---

## Outputs

| Output                 | Description                                     |
| ---------------------- | ----------------------------------------------- |
| `arn`                  | Full ARN of the task definition (with revision) |
| `arn_without_revision` | ARN without revision suffix                     |
| `revision`             | Task definition revision number                 |
| `family`               | Task definition family                          |
| `tags_all`             | All tags applied to the resource                |

---

## Example Scenarios

### Scenario 1: Minimal EC2 Task

```hcl
module "ecs_task_ec2" {
  source                = "./path/to/ecs-task-definition"
  family                = "ec2-task"
  container_definitions = file("ec2.json")
}
```

### Scenario 2: Windows Fargate Task

```hcl
module "ecs_task_windows" {
  source = "./path/to/ecs-task-definition"

  family                   = "windows-task"
  container_definitions    = file("windows.json")
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  cpu                      = "2048"
  memory                   = "4096"

  runtime_platform = {
    operating_system_family = "WINDOWS_SERVER_2019_CORE"
    cpu_architecture        = "X86_64"
  }
}
```

---

## Import

Terraform v1.5.0 and later supports import blocks:

```hcl
import {
  to = aws_ecs_task_definition.this
  id = "arn:aws:ecs:us-east-1:123456789012:task-definition/mytask:12"
}
```

Or via CLI:

```bash
terraform import aws_ecs_task_definition.this arn:aws:ecs:us-east-1:123456789012:task-definition/mytask:12
```

---

## Authors

Module is maintained by **David Essien**.

---

## License

This project is licensed under the **MIT License**. See `LICENSE` for details.
