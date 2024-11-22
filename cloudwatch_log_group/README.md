# AWS CloudWatch Log Group Terraform Module

This Terraform module creates an AWS CloudWatch Log Group with customizable settings.

## Features

- Supports optional settings like log group name, retention period, KMS encryption, and log group class.
- Allows tagging for resource identification and management.
- Provides outputs for the Log Group ARN and name.

## Usage

```hcl
module "cloudwatch_log_group" {
  source = "./path-to-module"

  name               = "example-log-group"
  retention_in_days  = 30
  kms_key_id         = "arn:aws:kms:us-east-1:123456789012:key/example-key"
  skip_destroy       = true
  log_group_class    = "STANDARD"
  tags = {
    Environment = "production"
    Team        = "devops"
  }
}
```

## Inputs

| Name                | Description                                                                         | Type          | Default |
| ------------------- | ----------------------------------------------------------------------------------- | ------------- | ------- |
| `name`              | The name of the log group. If omitted, a random unique name is generated.           | `string`      | `null`  |
| `name_prefix`       | Creates a unique name beginning with the specified prefix. Conflicts with name.     | `string`      | `null`  |
| `retention_in_days` | Number of days to retain log events. Use `0` for indefinite retention.              | `number`      | `null`  |
| `kms_key_id`        | The ARN of the KMS Key for encrypting log data.                                     | `string`      | `null`  |
| `skip_destroy`      | Prevent the log group and logs from being deleted at destroy time.                  | `bool`        | `false` |
| `log_group_class`   | The log class of the log group. Possible values: `STANDARD` or `INFREQUENT_ACCESS`. | `string`      | `null`  |
| `tags`              | A map of tags to assign to the log group.                                           | `map(string)` | `{}`    |

## Outputs

| Name             | Description                           |
| ---------------- | ------------------------------------- |
| `log_group_arn`  | The ARN of the CloudWatch Log Group.  |
| `log_group_name` | The name of the CloudWatch Log Group. |

## Notes

- If `retention_in_days` is not set, the log group will retain logs indefinitely.
- Ensure the specified KMS key ARN is valid and accessible for encryption when using `kms_key_id`.
