# AWS LOADBALANCER MODULE

This Terraform module creates and manages an AWS Load Balancer (`aws_lb`) with configurable properties for both Application Load Balancer (ALB) and Network Load Balancer (NLB).

---

### **Usage**

```hcl
module "load_balancer" {
  source = "./path-to-module"

  name                  = "my-load-balancer"
  internal              = false
  load_balancer_type    = "application"
  security_groups       = ["sg-0123456789abcdef"]
  subnets               = ["subnet-abcdef1234567890", "subnet-9876543210fedcba"]
  idle_timeout          = 120
  enable_http2          = true
  enable_deletion_protection = false
  tags = {
    Environment = "production"
    Project     = "my-project"
  }
}
```

---

### **Requirements**

| Name         | Version  |
| ------------ | -------- |
| Terraform    | >= 1.3.0 |
| AWS Provider | >= 5.0.0 |

---

### **Providers**

| Name  | Version  |
| ----- | -------- |
| `aws` | >= 5.0.0 |

---

### **Features**

- **Flexible Load Balancer Types**: Supports Application Load Balancer (ALB), Network Load Balancer (NLB), and Gateway Load Balancer (GLB).
- **Customizable Subnets and Security Groups**: Allows attaching subnets and security groups for tailored configurations.
- **Idle Timeout and HTTP/2**: Configure idle connection duration and HTTP/2 for ALBs.
- **Cross-Zone Load Balancing**: Supports cross-zone load balancing for optimal traffic distribution.
- **Access Logs**: Optional logging for detailed insights into requests.
- **Deletion Protection**: Prevents accidental deletions.
- **Tagging Support**: Assign tags for resource organization and cost tracking.

---

### **Explanation of Files**

1. **`main.tf`**  
   Defines the AWS Load Balancer resource and includes configurations for ALB, NLB, and GLB based on input parameters.

2. **`variables.tf`**  
   Declares the input variables for the module, including defaults, descriptions, and types.

3. **`outputs.tf`**  
   Exposes essential information about the created load balancer, such as its ARN, ID, DNS name, and zone ID.

4. **`README.md`**  
   Provides a comprehensive guide for using the module, including examples, input descriptions, outputs, and licensing.

---

### **Inputs**

| Name                               | Description                                                                     | Type           | Default                                      | Required |
| ---------------------------------- | ------------------------------------------------------------------------------- | -------------- | -------------------------------------------- | -------- |
| `name`                             | The name of the load balancer. Must be unique per region.                       | `string`       | `null`                                       | Yes      |
| `name_prefix`                      | Prefix for the name of the load balancer.                                       | `string`       | `null`                                       | No       |
| `internal`                         | Indicates whether the load balancer is internal (`true`) or external (`false`). | `bool`         | `false`                                      | Yes      |
| `load_balancer_type`               | The type of load balancer (`application`, `network`, `gateway`).                | `string`       | `"application"`                              | Yes      |
| `security_groups`                  | List of security group IDs for the load balancer (ALBs only).                   | `list(string)` | `[]`                                         | Yes      |
| `subnets`                          | List of subnet IDs to attach to the load balancer.                              | `list(string)` | `[]`                                         | Yes      |
| `ip_address_type`                  | Type of IP addresses used by the load balancer (`ipv4` or `dualstack`).         | `string`       | `"ipv4"`                                     | No       |
| `enable_deletion_protection`       | Enables or disables deletion protection for the load balancer.                  | `bool`         | `false`                                      | No       |
| `idle_timeout`                     | Time in seconds to keep idle connections open.                                  | `number`       | `60`                                         | No       |
| `enable_http2`                     | Whether HTTP/2 is enabled.                                                      | `bool`         | `true`                                       | No       |
| `enable_cross_zone_load_balancing` | Enables or disables cross-zone load balancing (ALBs and NLBs).                  | `bool`         | `false`                                      | No       |
| `tags`                             | A map of tags to assign to the load balancer.                                   | `map(string)`  | `{}`                                         | No       |
| `access_logs_enabled`              | Enables access logs for the load balancer.                                      | `bool`         | `false`                                      | No       |
| `access_logs`                      | Configuration for access logs.                                                  | `object`       | See `variables.tf`                           | No       |
| `timeouts`                         | Timeouts for creating, updating, and deleting the load balancer.                | `object`       | `{create="10m", update="10m", delete="10m"}` | No       |

---

### **Outputs**

| Name       | Description                        |
| ---------- | ---------------------------------- |
| `id`       | The ID of the load balancer.       |
| `arn`      | The ARN of the load balancer.      |
| `dns_name` | The DNS name of the load balancer. |
| `zone_id`  | The Zone ID of the load balancer.  |

---

### **Examples**

#### Example: Application Load Balancer

```hcl
module "app_load_balancer" {
  source = "./path-to-module"

  name                  = "my-alb"
  load_balancer_type    = "application"
  internal              = false
  security_groups       = ["sg-abcdef123456"]
  subnets               = ["subnet-123", "subnet-456"]
  enable_http2          = true
  tags = {
    Project = "example-app"
  }
}
```

#### Example: Network Load Balancer

```hcl
module "network_load_balancer" {
  source = "./path-to-module"

  name                  = "my-nlb"
  load_balancer_type    = "network"
  internal              = false
  subnets               = ["subnet-abc", "subnet-def"]
  tags = {
    Project = "example-network"
  }
}
```

---

### **Authors**

This module is maintained by **David Essien** and the [David Essien](https://davidessien.com) team.

---

### **License**

This project is licensed under the MIT License. See the `LICENSE` file for details.
