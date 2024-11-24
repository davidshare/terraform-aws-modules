# AWS AUTOSCALING ATTACHMENT MODULE

This Terraform module creates and manages an AWS Auto Scaling Attachment (`aws_autoscaling_attachment`) for associating an Auto Scaling group with either a Classic Load Balancer (ELB) or a Load Balancer Target Group (ALB/NLB).

---

### **Usage**

```hcl
module "autoscaling_attachment" {
  source = "./path-to-module"

  autoscaling_group_name = "my-auto-scaling-group"
  elb                   = "my-classic-load-balancer"    # Optional: Use if attaching to Classic Load Balancer
  lb_target_group_arn   = "arn:aws:elasticloadbalancing:..."  # Optional: Use if attaching to a target group
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

- **Classic Load Balancer Support**: Attach an Auto Scaling group to a Classic Load Balancer (ELB).
- **Target Group Support**: Attach an Auto Scaling group to a Target Group for Application Load Balancer (ALB) or Network Load Balancer (NLB).
- **Conditional Attachment**: Supports conditional logic for either ELB or Target Group attachment based on the provided inputs.

---

### **Explanation of Files**

1. **`main.tf`**  
   Defines the `aws_autoscaling_attachment` resource that attaches an Auto Scaling group to either an ELB or a Target Group.

2. **`variables.tf`**  
   Declares input variables for the module, including the Auto Scaling group name and optional parameters for the load balancer or target group.

3. **`outputs.tf`**  
   Outputs the ID of the Auto Scaling Attachment created.

4. **`README.md`**  
   Provides a guide for using the module, detailing the required and optional inputs, and usage examples.

---

### **Inputs**

| Name                     | Description                                                                           | Type     | Default | Required |
| ------------------------ | ------------------------------------------------------------------------------------- | -------- | ------- | -------- |
| `autoscaling_group_name` | The name of the Auto Scaling group to associate with the load balancer.               | `string` | `null`  | Yes      |
| `elb`                    | The name of the Classic Load Balancer to attach to the Auto Scaling group (optional). | `string` | `null`  | No       |
| `lb_target_group_arn`    | ARN of the Load Balancer target group to attach to the Auto Scaling group (optional). | `string` | `null`  | No       |

---

### **Outputs**

| Name | Description                            |
| ---- | -------------------------------------- |
| `id` | The ID of the Auto Scaling attachment. |

---

### **Example**

#### Example: Attach Auto Scaling Group to Classic Load Balancer

```hcl
module "asg_attachment_elb" {
  source = "./path-to-module"

  autoscaling_group_name = "example-asg"
  elb                   = "my-classic-load-balancer"
}
```

#### Example: Attach Auto Scaling Group to Target Group

```hcl
module "asg_attachment_target_group" {
  source = "./path-to-module"

  autoscaling_group_name = "example-asg"
  lb_target_group_arn   = "arn:aws:elasticloadbalancing:..."
}
```

#### Example: Conditional Attachment (Both ELB and Target Group)

```hcl
module "asg_attachment_both" {
  source = "./path-to-module"

  autoscaling_group_name = "example-asg"
  elb                   = "my-classic-load-balancer"
  lb_target_group_arn   = "arn:aws:elasticloadbalancing:..."
}
```

---

### **Authors**

This module is maintained by **[David Essien](https://davidessien.com)**.

---

### **License**

This project is licensed under the MIT License. See the `LICENSE` file for details.
