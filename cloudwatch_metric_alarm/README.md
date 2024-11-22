# AWS CloudWatch Metric Alarm Module

This Terraform module creates an AWS CloudWatch Metric Alarm with all available attributes, providing a comprehensive solution for monitoring and responding to AWS service metrics.

## Features

- Create CloudWatch alarms based on metrics, anomaly detection, or metric math expressions.
- Supports multiple actions for alarm states (OK, ALARM, INSUFFICIENT_DATA).
- Customizable dimensions, thresholds, evaluation periods, and more.
- Integration with Auto Scaling groups, SNS topics, and other AWS services.

## Usage

```hcl
module "cloudwatch_metric_alarm" {
  source = "./path-to-your-module"

  alarm_name                = "example-alarm"
  comparison_operator       = "GreaterThanOrEqualToThreshold"
  evaluation_periods        = 2
  metric_name               = "CPUUtilization"
  namespace                 = "AWS/EC2"
  period                    = 120
  statistic                 = "Average"
  threshold                 = 80
  alarm_description         = "This alarm monitors EC2 CPU utilization"
  insufficient_data_actions = []
  ok_actions                = []
  alarm_actions             = ["arn:aws:sns:region:account-id:example-topic"]
  actions_enabled           = true

  dimensions = {
    InstanceId = "i-abc123"
  }

  treat_missing_data = "ignore"

  tags = {
    Environment = "production"
    Team        = "devops"
  }
}
```

## Inputs

| Name                                    | Type           | Default     | Description                                                                                                                                                                  |
| --------------------------------------- | -------------- | ----------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `alarm_name`                            | `string`       | n/a         | The name of the alarm. Must be unique.                                                                                                                                       |
| `comparison_operator`                   | `string`       | n/a         | The arithmetic operation to use when comparing the statistic and threshold. Options include `GreaterThanOrEqualToThreshold`, `GreaterThanThreshold`, etc.                    |
| `evaluation_periods`                    | `number`       | n/a         | The number of periods over which data is compared to the specified threshold.                                                                                                |
| `metric_name`                           | `string`       | `null`      | The name of the metric associated with the alarm.                                                                                                                            |
| `namespace`                             | `string`       | `null`      | The namespace of the metric.                                                                                                                                                 |
| `period`                                | `number`       | `null`      | The granularity in seconds of the metric. Valid values are multiples of 60.                                                                                                  |
| `statistic`                             | `string`       | `null`      | The statistic to apply to the metric. Options include `SampleCount`, `Average`, `Sum`, `Minimum`, and `Maximum`.                                                             |
| `threshold`                             | `number`       | `null`      | The value against which the specified statistic is compared.                                                                                                                 |
| `threshold_metric_id`                   | `string`       | `null`      | The ID of the anomaly detection band when using anomaly detection models.                                                                                                    |
| `actions_enabled`                       | `bool`         | `true`      | Whether actions should be executed during state changes of the alarm.                                                                                                        |
| `alarm_actions`                         | `list(string)` | `[]`        | The list of actions to execute when this alarm transitions into the ALARM state.                                                                                             |
| `ok_actions`                            | `list(string)` | `[]`        | The list of actions to execute when this alarm transitions into the OK state.                                                                                                |
| `insufficient_data_actions`             | `list(string)` | `[]`        | The list of actions to execute when this alarm transitions into the INSUFFICIENT_DATA state.                                                                                 |
| `alarm_description`                     | `string`       | `null`      | A description for the alarm.                                                                                                                                                 |
| `dimensions`                            | `map(string)`  | `{}`        | The dimensions for the metric.                                                                                                                                               |
| `datapoints_to_alarm`                   | `number`       | `null`      | The number of datapoints that must be breaching to trigger the alarm.                                                                                                        |
| `unit`                                  | `string`       | `null`      | The unit for the alarm's associated metric.                                                                                                                                  |
| `treat_missing_data`                    | `string`       | `"missing"` | Specifies how to treat missing data points. Options are `missing`, `ignore`, `breaching`, or `notBreaching`.                                                                 |
| `evaluate_low_sample_count_percentiles` | `string`       | `"ignore"`  | Whether to evaluate alarms during periods with too few data points. Options are `ignore` and `evaluate`.                                                                     |
| `metric_query`                          | `list(object)` | `[]`        | Enables creating alarms based on metric math expressions. See [AWS Docs](https://docs.aws.amazon.com/AmazonCloudWatch/latest/monitoring/using-metric-math.html) for details. |
| `tags`                                  | `map(string)`  | `{}`        | A map of tags to assign to the resource.                                                                                                                                     |

## Outputs

| Name       | Description                             |
| ---------- | --------------------------------------- |
| `arn`      | The ARN of the CloudWatch Metric Alarm. |
| `id`       | The ID of the CloudWatch Metric Alarm.  |
| `tags_all` | A map of tags assigned to the resource. |

## Examples

### Basic Usage

```hcl
module "cloudwatch_metric_alarm" {
  source = "./path-to-your-module"

  alarm_name          = "high-cpu-alarm"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = 2
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = 60
  statistic           = "Average"
  threshold           = 80
  actions_enabled     = true
  alarm_actions       = ["arn:aws:sns:region:account-id:example-topic"]
}
```

### Alarm Based on Metric Math Expression

```hcl
module "cloudwatch_metric_alarm" {
  source = "./path-to-your-module"

  alarm_name          = "error-rate-alarm"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = 3
  threshold           = 10

  metric_query = [
    {
      id          = "e1"
      expression  = "m2/m1*100"
      label       = "Error Rate"
      return_data = true
    },
    {
      id = "m1"
      metric = {
        metric_name = "RequestCount"
        namespace   = "AWS/ApplicationELB"
        period      = 120
        stat        = "Sum"
        unit        = "Count"
        dimensions  = {
          LoadBalancer = "app/example"
        }
      }
    },
    {
      id = "m2"
      metric = {
        metric_name = "HTTPCode_ELB_5XX_Count"
        namespace   = "AWS/ApplicationELB"
        period      = 120
        stat        = "Sum"
        unit        = "Count"
        dimensions  = {
          LoadBalancer = "app/example"
        }
      }
    }
  ]
}
```

## License

This module is licensed under the MIT License. See the LICENSE file for details.
