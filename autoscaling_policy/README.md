# AWS Auto Scaling Policy Module

The **AWS Auto Scaling Policy Terraform Module** provides a simple and flexible way to define and manage scaling policies for AWS Auto Scaling Groups. The module enables dynamic, step-based, target tracking, and predictive scaling strategies, empowering users to automate their scaling policies with various configurations. By using this module, users can efficiently manage their scaling policies, ensuring the optimal performance and cost efficiency of their Auto Scaling Groups.

---

## Usage

### Code Example:

```hcl
module "autoscaling_policy" {
  source                  = "./autoscaling_policy"
  name                    = "example-policy"
  autoscaling_group_name    = "example-asg"
  adjustment_type         = "ChangeInCapacity"
  policy_type             = "SimpleScaling"
  scaling_adjustment      = 2
  cooldown                = 300
  target_tracking_configuration = {
    target_value = 50
  }
}
```

### Key Parameters:

- `name`: The name of the scaling policy (required).
- `autoscaling_group_name`: The name of the Auto Scaling group to which the policy applies (required).
- `adjustment_type`: Defines whether the scaling adjustment is an absolute number or a percentage (`ChangeInCapacity`, `ExactCapacity`, `PercentChangeInCapacity`).
- `policy_type`: Type of scaling policy (`SimpleScaling`, `StepScaling`, `TargetTrackingScaling`, `PredictiveScaling`).
- `scaling_adjustment`: The number of instances to add or remove.
- `cooldown`: Time in seconds between scaling activities.

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

## Features

- **Dynamic Scaling Policies**: Enables scaling based on capacity changes.
- **Predictive Scaling**: Utilizes anticipated demand for proactive scaling.
- **Target Tracking**: Maintains performance goals with automatic adjustments.
- **Step Scaling**: Creates policies with multiple scaling adjustments.
- **Custom Metric Support**: Leverages custom CloudWatch metrics for scaling decisions.

---

## Explanation of Files

| File           | Description                                                                |
| -------------- | -------------------------------------------------------------------------- |
| `main.tf`      | Contains the main logic for defining the AWS Auto Scaling policy resource. |
| `variables.tf` | Defines input variables used in the module for configuration.              |
| `outputs.tf`   | Defines the output values that will be returned after module execution.    |
| `README.md`    | Provides the documentation and usage details for the module.               |

---

## Inputs

| Variable                           | Description                                                                                             | Type   | Default         | Required |
| ---------------------------------- | ------------------------------------------------------------------------------------------------------- | ------ | --------------- | -------- |
| `name`                             | Name of the scaling policy.                                                                             | string | N/A             | Yes      |
| `autoscaling_group_name`           | The name of the Auto Scaling Group to associate with this policy.                                       | string | N/A             | Yes      |
| `adjustment_type`                  | The type of adjustment (`ChangeInCapacity`, `ExactCapacity`, `PercentChangeInCapacity`).                | string | null            | No       |
| `policy_type`                      | The scaling policy type (`SimpleScaling`, `StepScaling`, `TargetTrackingScaling`, `PredictiveScaling`). | string | "SimpleScaling" | No       |
| `estimated_instance_warmup`        | Time in seconds for the new instance to contribute CloudWatch metrics.                                  | number | null            | No       |
| `enabled`                          | Whether the scaling policy is enabled.                                                                  | bool   | true            | No       |
| `predictive_scaling_configuration` | Configuration for predictive scaling policy (optional).                                                 | object | null            | No       |
| `min_adjustment_magnitude`         | Minimum value to scale by when adjustment type is set to `PercentChangeInCapacity`.                     | number | null            | No       |
| `cooldown`                         | Time in seconds between scaling activities.                                                             | number | null            | No       |
| `scaling_adjustment`               | Number of instances to add/remove during scaling activity.                                              | number | null            | No       |
| `metric_aggregation_type`          | Aggregation type for policy metrics (`Minimum`, `Maximum`, `Average`).                                  | string | null            | No       |
| `step_adjustment`                  | List of adjustments for step scaling policies.                                                          | list   | []              | No       |
| `target_tracking_configuration`    | Configuration for target tracking scaling policy (optional).                                            | object | null            | No       |

---

## Outputs

| Output                   | Description                                                               |
| ------------------------ | ------------------------------------------------------------------------- |
| `arn`                    | The ARN assigned to the scaling policy.                                   |
| `name`                   | The name of the scaling policy.                                           |
| `autoscaling_group_name` | The name of the Auto Scaling group that the scaling policy is applied to. |
| `adjustment_type`        | The adjustment type for the scaling policy (`ChangeInCapacity`, etc.).    |
| `policy_type`            | The type of scaling policy (`SimpleScaling`, `StepScaling`, etc.).        |

---

## Example Usage

### Example 1: Simple Scaling Policy

```hcl
module "autoscaling_policy" {
  source                  = "./autoscaling_policy"
  name                    = "simple-scaling-policy"
  autoscaling_group_name    = "my-auto-scaling-group"
  adjustment_type         = "ChangeInCapacity"
  policy_type             = "SimpleScaling"
  scaling_adjustment      = 1
  cooldown                = 300
}
```

### Example 2: Target Tracking Scaling Policy

```hcl
module "autoscaling_policy" {
  source                  = "./autoscaling_policy"
  name                    = "target-tracking-policy"
  autoscaling_group_name    = "my-auto-scaling-group"
  policy_type             = "TargetTrackingScaling"
  target_tracking_configuration = {
    target_value = 50
  }
}
```

---

## Authors

This module is maintained by [David Essien](https://davidessien.com).

---

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
