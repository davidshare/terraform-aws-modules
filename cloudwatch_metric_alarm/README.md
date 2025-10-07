# AWS CloudWatch Metric Alarm Terraform Module

This Terraform module simplifies the creation and configuration of AWS CloudWatch Metric Alarms, allowing monitoring and alerting based on specified metric thresholds or anomaly detection.

The module helps automate the setup of CloudWatch alarms with customizable conditions, actions, and advanced features like metric queries and anomaly detection, ensuring efficient monitoring for AWS resources.

---

## Usage

### Code Example

```hcl
module "cloudwatch_metric_alarm" {
  source              = "./cloudwatch_metric_alarm"
  alarm_name          = "HighCPUUtilization"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = 2
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = 300
  statistic           = "Average"
  threshold           = 80
  actions_enabled     = true
  alarm_actions       = ["arn:aws:sns:region:account-id:alarm-notification"]
  ok_actions          = ["arn:aws:sns:region:account-id:ok-notification"]
  tags = {
    Environment = "Production"
    Project     = "Monitoring"
  }
}
```

### Explanation of Key Parameters

- **alarm_name**: A descriptive name for the alarm.
- **comparison_operator**: Defines the condition for the alarm (e.g., greater than or less than).
- **evaluation_periods**: Number of periods to evaluate before triggering the alarm.
- **metric_name**: Name of the metric being monitored (e.g., `CPUUtilization`).
- **threshold**: The value to compare the metric against.
- **alarm_actions**: List of actions (e.g., SNS topics) to perform when the alarm state changes.

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

- **Threshold Alarms**: Trigger alarms based on a defined threshold and operator.
- **Anomaly Detection**: Supports alarms for anomaly detection bands.
- **Custom Actions**: Execute specific actions on state changes (ALARM, OK, or INSUFFICIENT_DATA).
- **Metric Queries**: Advanced monitoring using metric query expressions.
- **Tagging**: Enables assigning tags for better resource management.

---

## Explanation of Files

| File           | Description                                                              |
| -------------- | ------------------------------------------------------------------------ |
| `main.tf`      | Defines the AWS CloudWatch Metric Alarm resource and its configurations. |
| `variables.tf` | Contains variable definitions with descriptions, types, and defaults.    |
| `outputs.tf`   | Outputs the ARN and ID of the created alarm.                             |
| `README.md`    | Documentation for using and configuring the module.                      |

---

## Inputs

| Variable                    | Description                                                                          | Type           | Default   | Required |
| --------------------------- | ------------------------------------------------------------------------------------ | -------------- | --------- | -------- |
| `alarm_name`                | A descriptive name for the alarm.                                                    | `string`       |           | yes      |
| `comparison_operator`       | The operation to compare the statistic and threshold (e.g., `GreaterThanThreshold`). | `string`       |           | yes      |
| `evaluation_periods`        | Number of periods to evaluate before triggering the alarm.                           | `number`       |           | yes      |
| `metric_name`               | Name of the metric associated with the alarm.                                        | `string`       | `null`    | no       |
| `namespace`                 | Namespace of the metric (e.g., `AWS/EC2`).                                           | `string`       | `null`    | no       |
| `period`                    | Time period (in seconds) over which the statistic is applied.                        | `number`       | `null`    | no       |
| `statistic`                 | Statistic to apply to the metric (e.g., `Average`).                                  | `string`       | `null`    | no       |
| `threshold`                 | Threshold value to compare against the specified statistic.                          | `number`       | `null`    | no       |
| `alarm_actions`             | Actions to execute when the alarm transitions into the `ALARM` state.                | `list(string)` | `[]`      | no       |
| `ok_actions`                | Actions to execute when the alarm transitions into the `OK` state.                   | `list(string)` | `[]`      | no       |
| `insufficient_data_actions` | Actions to execute when the alarm transitions into the `INSUFFICIENT_DATA` state.    | `list(string)` | `[]`      | no       |
| `dimensions`                | Dimensions for the alarm's associated metric.                                        | `map(string)`  | `{}`      | no       |
| `treat_missing_data`        | Defines how to treat missing data points (`missing`, `breaching`, etc.).             | `string`       | `missing` | no       |
| `metric_query`              | List of metric queries for alarms based on expressions.                              | `list(object)` | `[]`      | no       |
| `tags`                      | Tags to assign to the metric alarm.                                                  | `map(string)`  | `{}`      | no       |

---

## Outputs

| Output | Description                             |
| ------ | --------------------------------------- |
| `arn`  | The ARN of the CloudWatch Metric Alarm. |
| `id`   | The ID of the CloudWatch Metric Alarm.  |

---

## Example Usage

### Basic Alarm Example

```hcl
module "basic_alarm" {
  source              = "./cloudwatch_metric_alarm"
  alarm_name          = "HighMemoryUtilization"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 3
  metric_name         = "MemoryUtilization"
  namespace           = "Custom/EC2"
  period              = 300
  statistic           = "Maximum"
  threshold           = 85
}
```

### Advanced Metric Query Alarm Example

```hcl
module "metric_query_alarm" {
  source              = "./cloudwatch_metric_alarm"
  alarm_name          = "CustomMetricAlarm"
  evaluation_periods  = 2
  comparison_operator = "GreaterThanThreshold"
  metric_query = [
    {
      id          = "m1"
      expression  = "SUM(METRICS('CPUUtilization'))"
      label       = "CPU Utilization Sum"
      return_data = true
      metric = {
        metric_name = "CPUUtilization"
        namespace   = "AWS/EC2"
        period      = 300
        stat        = "Sum"
        unit        = "Percent"
        dimensions  = {
          InstanceId = "i-0123456789abcdef0"
        }
      }
    }
  ]
  threshold = 80
}
```

---

## Authors

This module is maintained by [David Essien](https://davidessien.com).

---

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.
