# AWS CloudWatch Log Group Terraform Module

## Brief Description

This Terraform module facilitates the creation and management of AWS CloudWatch Log Groups with support for customizable configurations like retention periods, encryption, and tagging.

## Purpose of the Module

The module simplifies the deployment of CloudWatch Log Groups by providing flexible options for naming, retention settings, encryption, and lifecycle management, enabling efficient log storage and compliance with organizational requirements.

---

## Usage

### Code Example

```hcl
module "cloudwatch_log_group" {
  source            = "./cloudwatch_log_group"
  name              = "my-log-group"
  retention_in_days = 90
  kms_key_id        = "arn:aws:kms:region:account-id:key/key-id"
  skip_destroy      = true
  tags = {
    Environment = "Production"
    Project     = "MyProject"
  }
}
```

### Explanation of Key Parameters

- **name**: The name of the log group. If not provided, a unique name is generated.
- **retention_in_days**: The number of days to retain log events. A value of `0` means logs are retained indefinitely.
- **kms_key_id**: The ARN of the KMS key for encrypting log data.
- **skip_destroy**: Prevents the log group and its logs from being deleted when the resource is destroyed.
- **tags**: Key-value pairs for tagging the log group.

---

## Requirements

| Terraform Version | AWS Provider Version |
| ----------------- | -------------------- |
| 1.0+              | 3.50+                |

---

## Providers

| Provider | Version |
| -------- | ------- |
| `aws`    | 3.50+   |

---

## Features

- **Retention Policies**: Define how long logs are retained (1 day to indefinitely).
- **Encryption**: Supports encryption with KMS keys for secure log storage.
- **Lifecycle Control**: Allows skipping destruction of log groups for data preservation.
- **Tags**: Enables assigning metadata tags to log groups for better resource management.

---

## Explanation of Files

| File           | Description                                                           |
| -------------- | --------------------------------------------------------------------- |
| `main.tf`      | Defines the AWS CloudWatch Log Group resource and its configurations. |
| `variables.tf` | Contains variable definitions with descriptions, types, and defaults. |
| `outputs.tf`   | Outputs the ARN and name of the created log group.                    |
| `README.md`    | Documentation for using and configuring the module.                   |

---

## Inputs

| Variable            | Description                                                                       | Type          | Default | Required |
| ------------------- | --------------------------------------------------------------------------------- | ------------- | ------- | -------- |
| `name`              | The name of the log group. If omitted, a random unique name is generated.         | `string`      | `null`  | no       |
| `name_prefix`       | Creates a unique name beginning with the specified prefix. Conflicts with `name`. | `string`      | `null`  | no       |
| `retention_in_days` | Number of days to retain log events. Use `0` for indefinite retention.            | `number`      | `null`  | no       |
| `kms_key_id`        | The ARN of the KMS Key for encrypting log data.                                   | `string`      | `null`  | no       |
| `skip_destroy`      | Prevents the log group and logs from being deleted during resource destruction.   | `bool`        | `false` | no       |
| `log_group_class`   | Specifies the log class. Possible values: `STANDARD` or `INFREQUENT_ACCESS`.      | `string`      | `null`  | no       |
| `tags`              | A map of tags to assign to the log group.                                         | `map(string)` | `{}`    | no       |

---

## Outputs

| Output           | Description                           |
| ---------------- | ------------------------------------- |
| `arn`  | The ARN of the CloudWatch Log Group.  |
| `name` | The name of the CloudWatch Log Group. |

---

## Example Usage

### Basic Example

```hcl
module "cloudwatch_log_group" {
  source            = "./cloudwatch_log_group"
  name              = "application-logs"
  retention_in_days = 30
}
```

### Advanced Example

```hcl
module "cloudwatch_log_group" {
  source            = "./cloudwatch_log_group"
  name_prefix       = "app-logs-"
  retention_in_days = 365
  kms_key_id        = "arn:aws:kms:region:account-id:key/key-id"
  skip_destroy      = true
  tags = {
    Application = "Backend"
    Environment = "Staging"
  }
}
```

---

## Authors

This module is maintained by [David Essien](https://davidessien.com).

---

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for more details.
