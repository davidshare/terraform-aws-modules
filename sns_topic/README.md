### AWS Terraform Module: SNS Topic

This module creates and manages an AWS SNS Topic, allowing you to configure advanced settings for message delivery, encryption, and feedback.

---

### **Usage**

#### Example Configuration

```hcl
module "sns_topic" {
  source = "./sns_topic"

  name                  = "my-topic"
  display_name          = "My Topic Display Name"
  fifo_topic            = false
  kms_master_key_id     = "arn:aws:kms:us-east-1:123456789012:key/abcdef12-1234-5678-90ab-abcdef123456"
  tags = {
    Environment = "Production"
    Team        = "DevOps"
  }
}
```

---

### **Features**

- Support for both **standard** and **FIFO** topics.
- Optional encryption using AWS KMS.
- Advanced delivery configurations:
  - HTTP/S success and failure feedback.
  - Lambda, SQS, and Firehose feedback integration.
- Customizable policies for access control and delivery.

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

| **File**       | **Description**                                               |
| -------------- | ------------------------------------------------------------- |
| `main.tf`      | Contains the SNS Topic resource definition.                   |
| `variables.tf` | Defines input variables for configuring the topic.            |
| `outputs.tf`   | Exports key attributes of the topic for use in other modules. |

---

### **Inputs**

| **Name**                                   | **Description**                                                                   | **Type**      | **Default** | **Required** |
| ------------------------------------------ | --------------------------------------------------------------------------------- | ------------- | ----------- | ------------ |
| `name`                                     | The name of the SNS topic. Conflicts with `name_prefix`.                          | `string`      | `null`      | No           |
| `name_prefix`                              | Creates a unique name beginning with the specified prefix. Conflicts with `name`. | `string`      | `null`      | No           |
| `display_name`                             | The display name for the topic.                                                   | `string`      | `null`      | No           |
| `policy`                                   | The fully-formed AWS policy as JSON.                                              | `string`      | `null`      | No           |
| `delivery_policy`                          | The SNS delivery policy as JSON.                                                  | `string`      | `null`      | No           |
| `kms_master_key_id`                        | The ARN of a KMS key for encrypting log data.                                     | `string`      | `null`      | No           |
| `signature_version`                        | Signature version for notifications. Options: `'1'`, `'2'`.                       | `string`      | `null`      | No           |
| `tracing_config`                           | Tracing mode for the SNS topic. Options: `'PassThrough'`, `'Active'`.             | `string`      | `null`      | No           |
| `fifo_topic`                               | Whether the topic is FIFO (First-In-First-Out).                                   | `bool`        | `false`     | No           |
| `content_based_deduplication`              | Enables content-based deduplication for FIFO topics.                              | `bool`        | `false`     | No           |
| `application_success_feedback_role_arn`    | The IAM role ARN for application success feedback.                                | `string`      | `null`      | No           |
| `application_success_feedback_sample_rate` | Percentage of successful application deliveries to sample.                        | `number`      | `null`      | No           |
| `application_failure_feedback_role_arn`    | The IAM role ARN for application failure feedback.                                | `string`      | `null`      | No           |
| `http_success_feedback_role_arn`           | The IAM role ARN for HTTP success feedback.                                       | `string`      | `null`      | No           |
| `http_success_feedback_sample_rate`        | Percentage of successful HTTP deliveries to sample.                               | `number`      | `null`      | No           |
| `http_failure_feedback_role_arn`           | The IAM role ARN for HTTP failure feedback.                                       | `string`      | `null`      | No           |
| `lambda_success_feedback_role_arn`         | The IAM role ARN for Lambda success feedback.                                     | `string`      | `null`      | No           |
| `lambda_success_feedback_sample_rate`      | Percentage of successful Lambda deliveries to sample.                             | `number`      | `null`      | No           |
| `lambda_failure_feedback_role_arn`         | The IAM role ARN for Lambda failure feedback.                                     | `string`      | `null`      | No           |
| `sqs_success_feedback_role_arn`            | The IAM role ARN for SQS success feedback.                                        | `string`      | `null`      | No           |
| `sqs_success_feedback_sample_rate`         | Percentage of successful SQS deliveries to sample.                                | `number`      | `null`      | No           |
| `sqs_failure_feedback_role_arn`            | The IAM role ARN for SQS failure feedback.                                        | `string`      | `null`      | No           |
| `firehose_success_feedback_role_arn`       | The IAM role ARN for Firehose success feedback.                                   | `string`      | `null`      | No           |
| `firehose_success_feedback_sample_rate`    | Percentage of successful Firehose deliveries to sample.                           | `number`      | `null`      | No           |
| `firehose_failure_feedback_role_arn`       | The IAM role ARN for Firehose failure feedback.                                   | `string`      | `null`      | No           |
| `tags`                                     | Key-value map of resource tags.                                                   | `map(string)` | `{}`        | No           |

---

### **Outputs**

| **Name** | **Description**            |
| -------- | -------------------------- |
| `arn`    | The ARN of the SNS topic.  |
| `name`   | The name of the SNS topic. |

---

### **Example Usages**

#### FIFO Topic

```hcl
module "sns_fifo_topic" {
  source = "./sns_topic"

  name                        = "my-fifo-topic.fifo"
  fifo_topic                  = true
  content_based_deduplication = true
}
```

#### Standard Topic with Feedback

```hcl
module "sns_standard_topic_with_feedback" {
  source = "./sns_topic"

  name = "standard-topic"
  lambda_success_feedback_role_arn = "arn:aws:iam::123456789012:role/lambda-feedback-role"
  lambda_success_feedback_sample_rate = 100
}
```

---

### **Authors**

Maintained by [David Essien](https://davidessien.com).

---

### **License**

This project is licensed under the MIT License.
