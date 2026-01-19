# Terraform AWS ECS Service Module

## Overview

This module creates and manages an **AWS ECS Service** (`aws_ecs_service`) in a **safe, flexible, and production-ready** manner.

It is designed to support **modern ECS usage patterns**, including:

* EC2, Fargate, and External launch types
* Capacity providers
* Load balancers (ALB / NLB / Classic ELB)
* Advanced deployment strategies (Rolling, Blue/Green, Linear, Canary)
* Deployment circuit breakers
* CloudWatch deployment alarms
* Service Connect
* Daemon and Replica scheduling strategies

The module also explicitly handles **AWS ECS and Terraform constraints**, including **mutually exclusive arguments** and **race-condition prevention during deletion**.

---

## ⚠️ Important AWS ECS Note (Deletion Safety)

To prevent ECS services from getting stuck in the `DRAINING` state during deletion:

> **Always ensure the ECS service depends on its related IAM role policies.**

This module exposes a `depends_on` variable so you can explicitly pass those dependencies.

Example:

```hcl
depends_on = [
  aws_iam_role_policy.ecs_service
]
```

---

## Requirements

| Name         | Version |
| ------------ | ------- |
| terraform    | >= 1.3  |
| aws provider | >= 5.0  |

---

## Supported ECS Service Patterns

This module supports:

* **REPLICA** and **DAEMON** scheduling strategies
* **EC2**, **FARGATE**, and **EXTERNAL** launch types
* **Capacity Provider Strategies**
* **Application Load Balancers / Network Load Balancers**
* **Service discovery**
* **Service Connect**
* **Blue/Green, Linear, Canary deployments**
* **CloudWatch deployment alarms**
* **Force redeploy on every apply**
* **External deployment controllers**

---

## Example Usage

### 1. Basic Fargate Service with ALB

```hcl
module "ecs_service" {
  source = "./modules/ecs-service"

  name            = "api"
  cluster         = aws_ecs_cluster.main.id
  task_definition = aws_ecs_task_definition.api.arn
  launch_type     = "FARGATE"
  desired_count   = 2

  network_configuration = {
    subnets         = aws_subnet.private[*].id
    security_groups = [aws_security_group.ecs.id]
  }

  load_balancers = [
    {
      target_group_arn = aws_lb_target_group.api.arn
      container_name   = "api"
      container_port   = 8080
    }
  ]

  depends_on = [
    aws_iam_role_policy.ecs_task_execution
  ]
}
```

---

### 2. Ignoring Desired Count Changes (Autoscaling-Friendly)

```hcl
resource "aws_ecs_service" "example" {
  desired_count = 2

  lifecycle {
    ignore_changes = [desired_count]
  }
}
```

---

### 3. Daemon Scheduling Strategy

```hcl
module "ecs_daemon" {
  source = "./modules/ecs-service"

  name                = "log-agent"
  cluster             = aws_ecs_cluster.main.id
  task_definition     = aws_ecs_task_definition.agent.arn
  scheduling_strategy = "DAEMON"
}
```

> **Note:** `desired_count` is automatically ignored for DAEMON services.

---

### 4. Capacity Provider Strategy (Mutually Exclusive with `launch_type`)

```hcl
module "ecs_cp" {
  source = "./modules/ecs-service"

  name            = "worker"
  cluster         = aws_ecs_cluster.main.id
  task_definition = aws_ecs_task_definition.worker.arn

  capacity_provider_strategy = [
    {
      capacity_provider = "FARGATE"
      weight            = 1
    }
  ]
}
```

---

### 5. Blue / Green Deployment Strategy

```hcl
deployment_configuration = {
  strategy             = "BLUE_GREEN"
  bake_time_in_minutes = 10
}
```

---

### 6. Canary Deployment Strategy

```hcl
deployment_configuration = {
  strategy             = "CANARY"
  bake_time_in_minutes = 15

  canary_configuration = {
    canary_percent              = 10
    canary_bake_time_in_minutes = 5
  }
}
```

---

### 7. Force Redeploy on Every Apply

```hcl
force_new_deployment = true

triggers = {
  redeploy = plantimestamp()
}
```

---

## Mutually Exclusive & Conditional Logic (Handled Automatically)

This module **safely enforces ECS constraints**:

| Constraint                                    | How the Module Handles It                    |
| --------------------------------------------- | -------------------------------------------- |
| `launch_type` vs `capacity_provider_strategy` | `launch_type` is automatically set to `null` |
| `DAEMON` scheduling                           | `desired_count` is ignored                   |
| `EXTERNAL` deployment controller              | `task_definition` is ignored                 |
| `awsvpc` network mode                         | Requires `network_configuration`             |
| Load balancer + non-awsvpc                    | Requires `iam_role`                          |

---

## Inputs

### Required Inputs

| Name      | Type   | Description           |
| --------- | ------ | --------------------- |
| `name`    | string | ECS service name      |
| `cluster` | string | ECS cluster ARN or ID |

---

### Optional Inputs

| Name                         | Type         | Default   | Description                     |
| ---------------------------- | ------------ | --------- | ------------------------------- |
| `task_definition`            | string       | `null`    | Task definition ARN             |
| `desired_count`              | number       | `0`       | Number of running tasks         |
| `scheduling_strategy`        | string       | `REPLICA` | REPLICA or DAEMON               |
| `launch_type`                | string       | `EC2`     | EC2, FARGATE, or EXTERNAL       |
| `capacity_provider_strategy` | list(object) | `null`    | Capacity provider configuration |
| `deployment_controller_type` | string       | `ECS`     | ECS, CODE_DEPLOY, EXTERNAL      |
| `deployment_circuit_breaker` | object       | `null`    | Deployment rollback logic       |
| `deployment_configuration`   | any          | `null`    | Advanced deployment strategies  |
| `network_configuration`      | any          | `null`    | Required for `awsvpc`           |
| `load_balancers`             | list(any)    | `[]`      | ALB/NLB/ELB config              |
| `iam_role`                   | string       | `null`    | Required for non-awsvpc LB      |
| `ordered_placement_strategy` | list(any)    | `[]`      | Placement strategy              |
| `placement_constraints`      | list(any)    | `[]`      | Placement constraints           |
| `alarms`                     | any          | `null`    | CloudWatch deployment alarms    |
| `enable_ecs_managed_tags`    | bool         | `true`    | Enable ECS managed tags         |
| `enable_execute_command`     | bool         | `false`   | Enable ECS Exec                 |
| `propagate_tags`             | string       | `null`    | SERVICE or TASK_DEFINITION      |
| `tags`                       | map(string)  | `{}`      | Resource tags                   |
| `triggers`                   | map(string)  | `{}`      | Redeploy triggers               |
| `depends_on`                 | list(any)    | `[]`      | Explicit dependencies           |

---

## Outputs

| Name   | Description             |
| ------ | ----------------------- |
| `arn`  | ARN of the ECS service  |
| `name` | Name of the ECS service |

---

## Importing Existing ECS Services

Terraform v1.5+ import block:

```hcl
import {
  to = module.ecs_service.aws_ecs_service.this
  id = "cluster-name/service-name"
}
```

CLI import:

```bash
terraform import aws_ecs_service.imported cluster-name/service-name
```

---

## Design Philosophy

This module intentionally:

* Avoids hidden magic
* Mirrors AWS ECS API behavior
* Enforces correctness through structure
* Supports advanced use cases without forcing complexity

It is suitable for:

* Production platforms
* Multi-environment setups
* GitOps workflows
* Blue/Green & Canary deployments
