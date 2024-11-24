### AWS Terraform Module: SNS Topic Subscription

This module creates and manages an AWS SNS Topic Subscription, enabling notifications to be sent to various endpoints.

---

### **Usage**

#### Example Configuration

```hcl
module "sns_topic_subscription" {
  source = "./sns_topic_subscription"

  topic_arn       = "arn:aws:sns:us-east-1:123456789012:my-topic"
  protocol        = "email"
  endpoint        = "example@example.com"
  raw_message_delivery = false

  tags = {
    Environment = "Production"
    Team        = "DevOps"
  }
}
```

---

### **Features**

- Supports all SNS subscription protocols (e.g., **email**, **lambda**, **http**, **sqs**).
- Allows setting advanced configurations, including:
  - Delivery policies.
  - Filter policies.
  - Redrive policies for dead-letter queues.

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

### **Explanation of Files**

| **File**       | **Description**                                                      |
| -------------- | -------------------------------------------------------------------- |
| `main.tf`      | Contains the SNS Topic Subscription resource definition.             |
| `variables.tf` | Defines input variables for configuring the subscription.            |
| `outputs.tf`   | Exports key attributes of the subscription for use in other modules. |

---

### **Inputs**

| **Name**                          | **Description**                                                                           | **Type** | **Default**           | **Required** |
| --------------------------------- | ----------------------------------------------------------------------------------------- | -------- | --------------------- | ------------ |
| `topic_arn`                       | The ARN of the SNS topic to subscribe to.                                                 | `string` | N/A                   | Yes          |
| `protocol`                        | Protocol to use for the subscription (e.g., `email`, `lambda`, `sqs`, etc.).              | `string` | N/A                   | Yes          |
| `endpoint`                        | The endpoint to send notifications to.                                                    | `string` | N/A                   | Yes          |
| `subscription_role_arn`           | IAM role ARN required for publishing to Kinesis Data Firehose (`firehose` protocol only). | `string` | `null`                | No           |
| `confirmation_timeout_in_minutes` | Number of minutes to wait for subscription confirmation before failure.                   | `number` | `1`                   | No           |
| `delivery_policy`                 | JSON string with delivery policies for HTTP/S subscriptions.                              | `string` | `null`                | No           |
| `endpoint_auto_confirms`          | Whether the endpoint auto-confirms subscriptions.                                         | `bool`   | `false`               | No           |
| `filter_policy`                   | JSON string for filtering messages based on attributes or body.                           | `string` | `null`                | No           |
| `filter_policy_scope`             | Specifies whether `filter_policy` applies to `MessageAttributes` or `MessageBody`.        | `string` | `"MessageAttributes"` | No           |
| `raw_message_delivery`            | Enables raw message delivery to the endpoint.                                             | `bool`   | `false`               | No           |
| `redrive_policy`                  | JSON string for configuring dead-letter queue redrive policies.                           | `string` | `null`                | No           |
| `replay_policy`                   | JSON string for archived message replay policies.                                         | `string` | `null`                | No           |

---

### **Outputs**

| **Name**                         | **Description**                                          |
| -------------------------------- | -------------------------------------------------------- |
| `subscription_arn`               | The ARN of the SNS subscription.                         |
| `owner_id`                       | The AWS account ID of the subscription owner.            |
| `pending_confirmation`           | Whether the subscription is pending confirmation.        |
| `confirmation_was_authenticated` | Whether the subscription confirmation was authenticated. |

---

### **Example Usages**

#### SQS Subscription with Filter Policy

```hcl
module "sns_to_sqs_subscription" {
  source = "./sns_topic_subscription"

  topic_arn = "arn:aws:sns:us-east-1:123456789012:my-topic"
  protocol  = "sqs"
  endpoint  = "arn:aws:sqs:us-east-1:123456789012:my-queue"
  filter_policy = <<EOT
  {
    "eventType": ["order_placed", "order_canceled"]
  }
  EOT
}
```

#### HTTP Subscription with Delivery Policy

```hcl
module "sns_http_subscription" {
  source = "./sns_topic_subscription"

  topic_arn       = "arn:aws:sns:us-east-1:123456789012:my-topic"
  protocol        = "http"
  endpoint        = "http://example.com/notifications"
  delivery_policy = <<EOT
  {
    "healthyRetryPolicy": {
      "numRetries": 5,
      "minDelayTarget": 20,
      "maxDelayTarget": 20
    }
  }
  EOT
}
```

---

### **Authors**

Maintained by [David Essien](https://davidessien.com).

---

### **License**

This project is licensed under the MIT License.
