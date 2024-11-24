# AWS Auto Scaling Attachment Module

This Terraform module manages the attachment of load balancers (either Classic Load Balancer or Application Load Balancer, Gateway Load Balancer, or Network Load Balancer target groups) to an Auto Scaling Group.

## Usage

To use this module, you need to have an Auto Scaling group and either a Classic Load Balancer or a Target Group created in AWS.

### Example Usage:

```hcl
module "autoscaling_attachment" {
  source                = "./path/to/your/module"
  autoscaling_group_name = aws_autoscaling_group.example.name
  elb                   = aws_elb.example.name
  lb_target_group_arn   = aws_lb_target_group.example.arn
}
```

### Variables:

| Name                     | Description                                                                                           | Type   | Default    |
| ------------------------ | ----------------------------------------------------------------------------------------------------- | ------ | ---------- |
| `autoscaling_group_name` | Name of the Auto Scaling Group to associate with the load balancer or target group.                   | string | (Required) |
| `elb`                    | The name of the Classic Load Balancer to attach to the Auto Scaling group (optional).                 | string | ""         |
| `lb_target_group_arn`    | ARN of the load balancer target group to attach to the Auto Scaling group (optional).                 | string | ""         |
| `traffic_source`         | Defines the traffic source for attachment: either "elb" (Classic Load Balancer) or "lb_target_group". | string | "elb"      |

### Outputs:

| Name                        | Description                                    |
| --------------------------- | ---------------------------------------------- |
| `autoscaling_attachment_id` | The ID of the created Auto Scaling attachment. |

### Explanation:

1. **`main.tf`**: This file defines the `aws_autoscaling_attachment` resource. It conditionally attaches either a Classic Load Balancer (`elb`) or a Target Group (`lb_target_group_arn`) to an Auto Scaling Group (`autoscaling_group_name`).

2. **`variables.tf`**: This file defines the variables for the module:

   - `autoscaling_group_name`: The name of the Auto Scaling group to attach the load balancer or target group.
   - `elb`: The name of the Classic Load Balancer to attach (optional).
   - `lb_target_group_arn`: The ARN of the Target Group to attach (optional).
   - `traffic_source`: Specifies the traffic source, either `elb` for Classic Load Balancer or `lb_target_group` for Target Groups.

3. **`outputs.tf`**: This file defines an output for the ID of the Auto Scaling attachment resource created.

4. **`README.md`**: Provides documentation for the module, including how to use it, available variables, and the outputs generated.

You can modify the values for `elb` or `lb_target_group_arn` based on whether you're using a Classic Load Balancer or an Application Load Balancer (ALB), Network Load Balancer (NLB), or Gateway Load Balancer target group. This module helps to easily manage the Auto Scaling group attachment to these load balancing resources.
