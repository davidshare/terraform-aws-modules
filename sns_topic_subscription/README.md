# AWS SNS Topic Subscription Terraform Module

This Terraform module creates an SNS Topic Subscription with customizable configurations.

## Features

- Supports various protocols including SQS, Lambda, HTTP/S, Firehose, and SMS.
- Configurable delivery policies, filter policies, and replay policies.
- Supports cross-account and cross-region subscriptions.

## Usage

```hcl
module "sns_topic_subscription" {
  source = "./path-to-module"

  topic_arn = "arn:aws:sns:us-west-2:123456789012:user-updates-topic"
  protocol  = "sqs"
  endpoint  = "arn:aws:sqs:us-west-2:123456789012:terraform-queue-too"
  tags = {
    Environment = "production"
    Team        = "devops"
  }
}
```

## Inputs

Refer to `variables.tf` for the complete list of configurable inputs.

## Outputs

| Name                             | Description                                              |
| -------------------------------- | -------------------------------------------------------- |
| `subscription_arn`               | The ARN of the SNS subscription.                         |
| `owner_id`                       | The AWS account ID of the subscription owner.            |
| `pending_confirmation`           | Whether the subscription is pending confirmation.        |
| `confirmation_was_authenticated` | Whether the subscription confirmation was authenticated. |

## Notes

- If using HTTP/S, ensure the endpoint can auto-confirm or confirm manually.
- For cross-region and cross-account setups, ensure the correct AWS provider is configured for both the SNS topic and the endpoint (e.g., SQS).
