# AWS SNS Topic Terraform Module

This Terraform module creates an AWS SNS Topic with full customization options.

## Features

- Supports FIFO and standard topics.
- Configurable delivery policies, encryption, and tracing.
- Feedback configuration for HTTP, Lambda, SQS, and Firehose endpoints.

## Usage

```hcl
module "sns_topic" {
  source = "./path-to-module"

  name        = "user-updates-topic"
  kms_key_id  = "alias/aws/sns"
  fifo_topic  = false
  tags = {
    Environment = "production"
    Application = "serviceA"
  }
}
```

## Inputs

Refer to `variables.tf` for the complete list of configurable inputs.

## Outputs

| Name             | Description                |
| ---------------- | -------------------------- |
| `sns_topic_arn`  | The ARN of the SNS topic.  |
| `sns_topic_name` | The name of the SNS topic. |

## Notes

- For FIFO topics, ensure the name ends with `.fifo` and configure `content_based_deduplication` as needed.
- Ensure appropriate IAM permissions for feedback configurations.
