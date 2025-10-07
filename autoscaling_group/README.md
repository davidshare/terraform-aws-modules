# AWS AUTOSCALING GROUP MODULE

This Terraform module creates and manages an AWS Auto Scaling Group (`aws_autoscaling_group`) with flexible configurations for scaling, health checks, and tags. It enables dynamic scaling of EC2 instances based on specified parameters.

---

### **Usage**

```hcl
module "autoscaling_group" {
  source = "./path-to-module"

  name                = "my-auto-scaling-group"
  min_size            = 1
  max_size            = 10
  desired_capacity    = 3
  vpc_zone_identifier = ["subnet-123", "subnet-456"]

  launch_template = {
    id      = "lt-0123456789abcdef"
    version = "1"
  }

  target_group_arns         = ["arn:aws:elasticloadbalancing:..."]
  health_check_type         = "EC2"
  health_check_grace_period = 300
  default_cooldown          = 300
  termination_policies      = ["Default"]

  tags = [
    {
      key                 = "Environment"
      value               = "Production"
      propagate_at_launch = true
    }
  ]
}
```

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

### **Features**

- **Launch Template Support**: Allows specifying an EC2 Launch Template for flexible instance configurations.
- **Dynamic Scaling**: Adjusts the number of instances based on minimum, maximum, and desired capacities.
- **Health Checks**: Includes EC2 and ELB health check types with configurable grace periods.
- **Tag Management**: Supports dynamic tags that propagate to launched instances.
- **Custom Termination Policies**: Specify policies for instance termination during scaling.
- **Subnet and Target Group Integration**: Easily integrates with VPC subnets and load balancer target groups.

---

### **Explanation of Files**

1. **`main.tf`**  
   Defines the AWS Auto Scaling Group resource, supporting custom tags, target group associations, and health checks.

2. **`variables.tf`**  
   Declares input variables, their types, default values, and descriptions.

3. **`outputs.tf`**  
   Outputs essential information about the Auto Scaling Group, including its ID, name, and ARN.

4. **`README.md`**  
   Provides a detailed guide on using the module, including inputs, outputs, and usage examples.

---

### **Inputs**

| Name                        | Description                                                                                                                                        | Type           | Default       | Required |
| --------------------------- | -------------------------------------------------------------------------------------------------------------------------------------------------- | -------------- | ------------- | -------- |
| `name`                      | The name of the Auto Scaling Group.                                                                                                                | `string`       | `null`        | Yes      |
| `min_size`                  | Minimum number of instances in the Auto Scaling Group.                                                                                             | `number`       | `null`        | Yes      |
| `max_size`                  | Maximum number of instances in the Auto Scaling Group.                                                                                             | `number`       | `null`        | Yes      |
| `desired_capacity`          | Desired number of instances in the Auto Scaling Group.                                                                                             | `number`       | `null`        | Yes      |
| `launch_template`           | Launch template specification to use when launching instances.                                                                                     | `object`       | `{}`          | Yes      |
| `vpc_zone_identifier`       | List of subnet IDs where the instances should be launched.                                                                                         | `list(string)` | `[]`          | Yes      |
| `target_group_arns`         | List of ARN(s) of target group(s) to associate with the Auto Scaling Group.                                                                        | `list(string)` | `[]`          | No       |
| `health_check_type`         | Type of health check to perform (`EC2`, `ELB`).                                                                                                    | `string`       | `"EC2"`       | No       |
| `health_check_grace_period` | The grace period, in seconds, after an instance comes into service before its health is checked.                                                   | `number`       | `300`         | No       |
| `default_cooldown`          | The amount of time, in seconds, after a scaling activity completes before another scaling activity can start.                                      | `number`       | `300`         | No       |
| `termination_policies`      | List of policies to use when terminating instances (`OldestInstance`, `NewestInstance`, etc.).                                                     | `list(string)` | `["Default"]` | No       |
| `tags`                      | A list of tag blocks to assign to the Auto Scaling Group and its instances. Each tag should have a `key`, `value`, and `propagate_at_launch` flag. | `list(object)` | `[]`          | No       |

---

### **Outputs**

| Name   | Description                       |
| ------ | --------------------------------- |
| `id`   | The Auto Scaling Group ID         |
| `name` | The Auto Scaling Group name       |
| `arn`  | The ARN of the Auto Scaling Group |

---

### **Examples**

#### Example: Basic Auto Scaling Group

```hcl
module "basic_asg" {
  source = "./path-to-module"

  name                = "example-asg"
  min_size            = 2
  max_size            = 5
  desired_capacity    = 3
  vpc_zone_identifier = ["subnet-123", "subnet-456"]

  launch_template = {
    id      = "lt-abc123"
    version = "1"
  }
}
```

#### Example: Auto Scaling Group with Tags and Target Groups

```hcl
module "asg_with_tags" {
  source = "./path-to-module"

  name                = "example-asg-tags"
  min_size            = 1
  max_size            = 10
  desired_capacity    = 2
  vpc_zone_identifier = ["subnet-xyz", "subnet-pqr"]

  launch_template = {
    id      = "lt-def456"
    version = "2"
  }

  target_group_arns = ["arn:aws:elasticloadbalancing:..."]

  tags = [
    {
      key                 = "Environment"
      value               = "Production"
      propagate_at_launch = true
    }
  ]
}
```

---

### **Authors**

This module is maintained by **[David Essien](https://davidessien.com)**.

---

### **License**

This project is licensed under the MIT License. See the `LICENSE` file for details.
