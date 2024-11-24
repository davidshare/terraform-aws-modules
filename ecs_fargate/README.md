### AWS Terraform Module: ECS Fargate

This Terraform module provisions an AWS ECS cluster and a Fargate service, enabling users to deploy containerized workloads using serverless infrastructure. It includes resources for an ECS cluster, task definitions, and a service, simplifying container orchestration.

---

### Usage

```hcl
module "ecs_fargate" {
  source = "./path/to/ecs_fargate"

  cluster_name          = "my-ecs-cluster"
  task_family           = "my-task-family"
  container_definitions = file("container_definitions.json")
  cpu                   = 512
  memory                = 1024
  execution_role_arn    = "arn:aws:iam::123456789012:role/ecsTaskExecutionRole"
  service_name          = "my-service"
  desired_count         = 2
  subnets               = ["subnet-abc123", "subnet-def456"]
  security_groups       = ["sg-123abc"]
  assign_public_ip      = true
  tags = {
    Environment = "Production"
    Owner       = "Team A"
  }
}
```

#### Key Parameters:

- `cluster_name`: Name of the ECS cluster.
- `task_family`: Unique identifier for the task definition family.
- `container_definitions`: JSON document defining the container configurations.
- `cpu` and `memory`: Specify the resources allocated to the task.
- `execution_role_arn`: IAM role ARN for ECS task execution permissions.
- `service_name`: Name of the ECS service.
- `subnets` and `security_groups`: Define the network configuration.
- `assign_public_ip`: Enable public IP assignment for tasks.

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

### Features

- Creates an ECS cluster with serverless Fargate launch type.
- Provisions task definitions with customizable container configurations.
- Deploys scalable ECS services with desired task counts.
- Supports secure networking with subnets and security groups.
- Flexible tagging for resource organization.

---

### Explanation of Files

| File           | Description                                                      |
| -------------- | ---------------------------------------------------------------- |
| `main.tf`      | Defines the ECS cluster, task definition, and service resources. |
| `variables.tf` | Declares the module's input variables.                           |
| `outputs.tf`   | Specifies the outputs provided by the module.                    |
| `README.md`    | Documentation for the module.                                    |

---

### Inputs

| Variable                | Description                                                      | Type           | Default   | Required |
| ----------------------- | ---------------------------------------------------------------- | -------------- | --------- | -------- |
| `cluster_name`          | Name of the ECS cluster.                                         | `string`       | -         | Yes      |
| `task_family`           | Unique name for the task definition.                             | `string`       | -         | Yes      |
| `container_definitions` | JSON document with container configurations.                     | `string`       | -         | Yes      |
| `cpu`                   | Number of CPU units for the task.                                | `number`       | -         | Yes      |
| `memory`                | Memory (in MiB) for the task.                                    | `number`       | -         | Yes      |
| `network_mode`          | Docker networking mode (`awsvpc`, etc.).                         | `string`       | `awsvpc`  | No       |
| `execution_role_arn`    | IAM role ARN for ECS task execution permissions.                 | `string`       | -         | Yes      |
| `task_role_arn`         | IAM role ARN for task permissions to interact with AWS services. | `string`       | `null`    | No       |
| `service_name`          | Name of the ECS service.                                         | `string`       | -         | Yes      |
| `desired_count`         | Number of task instances to keep running.                        | `number`       | `1`       | No       |
| `launch_type`           | Launch type for the service (`FARGATE`).                         | `string`       | `FARGATE` | No       |
| `subnets`               | Subnets for the service network configuration.                   | `list(string)` | -         | Yes      |
| `security_groups`       | Security groups for the service network configuration.           | `list(string)` | -         | Yes      |
| `assign_public_ip`      | Whether to assign a public IP address.                           | `bool`         | `false`   | No       |
| `tags`                  | Map of tags to apply to all resources.                           | `map(string)`  | `{}`      | No       |

---

### Outputs

| Output                | Description                     |
| --------------------- | ------------------------------- |
| `id`                  | ID of the ECS cluster.          |
| `arn`                 | ARN of the ECS cluster.         |
| `task_definition_arn` | ARN of the ECS task definition. |
| `service_id`          | ID of the ECS service.          |
| `service_name`        | Name of the ECS service.        |

---

### Example Usage

#### Scenario 1: Default Configuration

```hcl
module "ecs_default" {
  source               = "./path/to/ecs_fargate"
  cluster_name         = "default-cluster"
  task_family          = "default-task"
  container_definitions = file("default_container.json")
  cpu                  = 256
  memory               = 512
  subnets              = ["subnet-abc123"]
  security_groups      = ["sg-abc123"]
}
```

#### Scenario 2: Public-Facing Service

```hcl
module "ecs_public" {
  source               = "./path/to/ecs_fargate"
  cluster_name         = "public-cluster"
  task_family          = "public-task"
  container_definitions = file("public_container.json")
  cpu                  = 1024
  memory               = 2048
  execution_role_arn   = "arn:aws:iam::123456789012:role/ecsTaskExecutionRole"
  subnets              = ["subnet-xyz123"]
  security_groups      = ["sg-xyz123"]
  assign_public_ip     = true
}
```

---

### Authors

Module is maintained by [David Essien](https://davidessien.com).

---

### License

This project is licensed under the MIT License. See `LICENSE` for details.
