### AWS Terraform Module: Target Group

This module provisions an AWS Elastic Load Balancer (ELB) Target Group with configurable options like health checks, stickiness, and protocol settings.

---

### **Usage**

#### Example Configuration

```hcl
module "target_group" {
  source = "./target_group"

  name       = "example-tg"
  port       = 80
  protocol   = "HTTP"
  vpc_id     = "vpc-0abcd1234efgh5678"
  target_type = "instance"
  health_check = {
    enabled           = true
    path              = "/health"
    interval          = 30
    healthy_threshold = 3
    unhealthy_threshold = 2
  }
  tags = {
    Environment = "Production"
    Name        = "ExampleTargetGroup"
  }
}
```

---

### **Features**

- **Health Check**: Fully customizable health check configuration.
- **Stickiness**: Optional session stickiness for targets.
- **Flexible Target Types**: Supports `instance`, `ip`, and `lambda` target types.
- **Tagging**: Apply custom metadata to the target group.

---

### **Requirements**

| **Dependency** | **Version** |
| -------------- | ----------- |
| Terraform      | >= 1.3.0    |
| AWS Provider   | >= 4.0      |

---

### **Providers**

| **Name** | **Source**    |
| -------- | ------------- |
| `aws`    | hashicorp/aws |

---

### **Explanation of Files**

| **File**       | **Description**                                                      |
| -------------- | -------------------------------------------------------------------- |
| `main.tf`      | Contains the Target Group resource definition.                       |
| `variables.tf` | Defines input variables for target group configuration.              |
| `outputs.tf`   | Exports key attributes of the target group for use in other modules. |

---

### **Inputs**

| **Name**               | **Description**                                                                  | **Type**      | **Default** | **Required** |
| ---------------------- | -------------------------------------------------------------------------------- | ------------- | ----------- | ------------ |
| `name`                 | Name of the target group.                                                        | `string`      | N/A         | Yes          |
| `port`                 | Port on which targets receive traffic.                                           | `number`      | N/A         | Yes          |
| `protocol`             | Protocol to use for routing traffic to the targets (`HTTP`, `HTTPS`, etc.).      | `string`      | N/A         | Yes          |
| `vpc_id`               | Identifier of the VPC in which to create the target group.                       | `string`      | N/A         | Yes          |
| `target_type`          | Type of targets (`instance`, `ip`, or `lambda`).                                 | `string`      | `instance`  | No           |
| `deregistration_delay` | Time to wait before marking deregistered targets as unused (seconds).            | `number`      | `300`       | No           |
| `slow_start`           | Time for targets to warm up before receiving a full share of requests (seconds). | `number`      | `0`         | No           |
| `health_check`         | Configuration block for health checks.                                           | `object`      | `{}`        | No           |
| `stickiness`           | Configuration block for stickiness.                                              | `object`      | `null`      | No           |
| `tags`                 | A map of tags to add to the target group.                                        | `map(string)` | `{}`        | No           |

---

### **Outputs**

| **Name**            | **Description**           |
| ------------------- | ------------------------- |
| `arn`  | ARN of the target group.  |
| `name` | Name of the target group. |

---

### **Example Usages**

#### Basic Target Group

```hcl
module "basic_target_group" {
  source = "./target_group"

  name     = "basic-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = "vpc-0abcd1234efgh5678"
}
```

#### Target Group with Stickiness

```hcl
module "sticky_target_group" {
  source = "./target_group"

  name       = "sticky-tg"
  port       = 443
  protocol   = "HTTPS"
  vpc_id     = "vpc-0abcd1234efgh5678"
  stickiness = {
    type            = "lb_cookie"
    cookie_duration = 3600
    enabled         = true
  }
}
```

#### Target Group with Custom Health Check

```hcl
module "health_check_target_group" {
  source = "./target_group"

  name         = "health-tg"
  port         = 80
  protocol     = "HTTP"
  vpc_id       = "vpc-0abcd1234efgh5678"
  health_check = {
    enabled           = true
    path              = "/status"
    interval          = 20
    healthy_threshold = 3
    unhealthy_threshold = 5
    timeout           = 5
  }
}
```

---

### **Authors**

Maintained by [David Essien](https://davidessien.com).

---

### **License**

This project is licensed under the MIT License.
