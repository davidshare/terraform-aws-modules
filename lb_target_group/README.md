### AWS Terraform Module: Load Balancer Target Group

This Terraform module manages the creation and configuration of AWS Load Balancer Target Groups. It supports customization of target group settings, health checks, stickiness, and failover configurations.

---

### **Usage**

#### Example Configuration

```hcl
module "target_group" {
  source                      = "./lb_target_group"
  name                        = "my-target-group"
  port                        = 80
  protocol                    = "HTTP"
  vpc_id                      = "vpc-12345678"
  load_balancing_algorithm_type = "round_robin"
  health_check = {
    enabled             = true
    healthy_threshold   = 3
    interval            = 30
    matcher             = "200-399"
    path                = "/"
    port                = "traffic-port"
    protocol            = "HTTP"
    timeout             = 6
    unhealthy_threshold = 3
  }
  tags = {
    Environment = "Production"
  }
}
```

#### Explanation of Key Parameters

- **`name`**: The name of the target group.
- **`port`**: The port on which the target receives traffic.
- **`protocol`**: Protocol for traffic routing (e.g., HTTP, HTTPS).
- **`vpc_id`**: VPC ID where the target group is created.
- **`health_check`**: Configuration for health checks, ensuring target health monitoring.
- **`tags`**: Metadata tags for the target group.

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

### **Features**

- Creates AWS Load Balancer Target Groups.
- Configurable health checks for targets.
- Supports multiple target types: instance, IP, or Lambda.
- Customizable stickiness, load balancing algorithms, and failover policies.
- Flexible tagging for resource organization.

---

### **Explanation of Files**

| **File**       | **Description**                                                                |
| -------------- | ------------------------------------------------------------------------------ |
| `main.tf`      | Defines the main resource configuration for the target group.                  |
| `variables.tf` | Contains input variable definitions for configuring the module.                |
| `outputs.tf`   | Specifies the output values from the module for reuse in other configurations. |
| `README.md`    | Documentation providing details on usage, inputs, and outputs of the module.   |

---

### **Inputs**

| **Name**                             | **Description**                                 | **Type**      | **Default**                            | **Required** |
| ------------------------------------ | ----------------------------------------------- | ------------- | -------------------------------------- | ------------ |
| `name`                               | Name of the target group                        | `string`      | N/A                                    | Yes          |
| `port`                               | Port on which targets receive traffic           | `number`      | N/A                                    | Yes          |
| `protocol`                           | Protocol used for routing traffic               | `string`      | N/A                                    | Yes          |
| `vpc_id`                             | VPC ID where the target group will be created   | `string`      | N/A                                    | Yes          |
| `connection_termination`             | Terminate connections at deregistration timeout | `bool`        | `false`                                | No           |
| `deregistration_delay`               | Deregistration delay in seconds                 | `number`      | `300`                                  | No           |
| `lambda_multi_value_headers_enabled` | Enable multi-value headers for Lambda targets   | `bool`        | `false`                                | No           |
| `load_balancing_algorithm_type`      | Algorithm used for load balancing               | `string`      | `"round_robin"`                        | No           |
| `health_check`                       | Health check configuration                      | `object`      | (See default values in `variables.tf`) | No           |
| `stickiness`                         | Stickiness configuration                        | `object`      | (See default values in `variables.tf`) | No           |
| `tags`                               | Tags for the target group                       | `map(string)` | `{}`                                   | No           |

---

### **Outputs**

| **Name** | **Description**              |
| -------- | ---------------------------- |
| `arn`    | The ARN of the target group  |
| `name`   | The name of the target group |

---

### **Example Usage**

```hcl
module "target_group" {
  source                      = "./lb_target_group"
  name                        = "example-tg"
  port                        = 8080
  protocol                    = "HTTP"
  vpc_id                      = "vpc-abc12345"
  load_balancing_algorithm_type = "least_outstanding_requests"
  tags = {
    Project = "WebApp"
    Team    = "Backend"
  }
}
```

---

### **Authors**

Maintained by [David Essien](https://davidessien.com)

---

### **License**

This project is licensed under the MIT License.
