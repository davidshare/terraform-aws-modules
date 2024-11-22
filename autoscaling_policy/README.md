# AWS Auto Scaling Policy Terraform Module

A Terraform module to create and manage **AWS Auto Scaling Policies**. This module supports different scaling policy types, including `SimpleScaling`, `StepScaling`, `TargetTrackingScaling`, and `PredictiveScaling`, to dynamically adjust the size of an Auto Scaling Group based on your requirements.

## Features

- Support for all scaling policy types: `SimpleScaling`, `StepScaling`, `TargetTrackingScaling`, and `PredictiveScaling`.
- Configurable adjustment types, scaling adjustments, cooldown periods, and more.
- Target tracking scaling with predefined or customized CloudWatch metrics.
- Predictive scaling for advanced workload forecasting.
- Compatibility with any existing Auto Scaling Group.

---

## Usage

### Example: Simple Scaling Policy

```hcl
module "simple_scaling_policy" {
  source                = "./path-to-module"
  name                  = "simple-scaling-policy"
  autoscaling_group_name = aws_autoscaling_group.example.name
  adjustment_type       = "ChangeInCapacity"
  scaling_adjustment    = 3
  cooldown              = 300
}
```

### Example: Target Tracking Scaling Policy

```hcl
module "target_tracking_policy" {
  source                = "./path-to-module"
  name                  = "target-tracking-policy"
  autoscaling_group_name = aws_autoscaling_group.example.name
  policy_type           = "TargetTrackingScaling"
  target_tracking_configuration = {
    target_value = 50
    predefined_metric_specification = {
      predefined_metric_type = "ASGAverageCPUUtilization"
    }
  }
}
```

### Example: Predictive Scaling Policy

```hcl
module "predictive_scaling_policy" {
  source                = "./path-to-module"
  name                  = "predictive-scaling-policy"
  autoscaling_group_name = aws_autoscaling_group.example.name
  policy_type           = "PredictiveScaling"
  predictive_scaling_configuration = {
    metric_specification = {
      target_value = 20
      predefined_load_metric_specification = {
        predefined_metric_type = "ASGTotalCPUUtilization"
        resource_label         = "app/my-alb/target-group-id"
      }
    }
  }
}
```

---

## Inputs

| Name                               | Description                                                                                              | Type     | Default           | Required |
| ---------------------------------- | -------------------------------------------------------------------------------------------------------- | -------- | ----------------- | -------- |
| `name`                             | Name of the scaling policy.                                                                              | `string` | n/a               | Yes      |
| `autoscaling_group_name`           | Name of the Auto Scaling Group.                                                                          | `string` | n/a               | Yes      |
| `adjustment_type`                  | Adjustment type: `ChangeInCapacity`, `ExactCapacity`, or `PercentChangeInCapacity`.                      | `string` | `null`            | No       |
| `scaling_adjustment`               | Number of instances to scale up or down. Applicable for SimpleScaling and StepScaling policies only.     | `number` | `null`            | No       |
| `cooldown`                         | Cooldown period (in seconds) between scaling activities.                                                 | `number` | `null`            | No       |
| `policy_type`                      | Type of scaling policy: `SimpleScaling`, `StepScaling`, `TargetTrackingScaling`, or `PredictiveScaling`. | `string` | `"SimpleScaling"` | No       |
| `target_tracking_configuration`    | Configuration block for target tracking scaling policies.                                                | `object` | `null`            | No       |
| `predictive_scaling_configuration` | Configuration block for predictive scaling policies.                                                     | `object` | `null`            | No       |

---

## Outputs

| Name                  | Description                          |
| --------------------- | ------------------------------------ |
| `scaling_policy_id`   | The ID of the Auto Scaling Policy.   |
| `scaling_policy_name` | The name of the Auto Scaling Policy. |
| `scaling_policy_arn`  | The ARN of the Auto Scaling Policy.  |

---

## How It Works

1. **SimpleScaling**: Adjust the number of instances in an Auto Scaling Group based on predefined rules, such as scaling by a specific number or percentage.
2. **StepScaling**: Perform step-based scaling actions based on CloudWatch alarms and thresholds.
3. **TargetTrackingScaling**: Scale dynamically to maintain a target value of a specific metric, such as CPU utilization.
4. **PredictiveScaling**: Use machine learning models to predict traffic and scale in advance of anticipated demand.

---

## Prerequisites

- An AWS Auto Scaling Group must be created beforehand.
- Ensure appropriate IAM permissions are in place to manage Auto Scaling Policies.

---

## Authors

This module is maintained by **[Your Name/Organization]**.

---

## License

This project is licensed under the **MIT License**. See the `LICENSE` file for more details.
