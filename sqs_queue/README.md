### AWS Terraform Module: SQS Queue

This module creates an Amazon SQS Queue with configurable options for FIFO queues, encryption, deduplication, and message management.

---

### **Usage**

#### Example Configuration

```hcl
module "sqs_queue" {
  source = "./sqs_queue"

  name                          = "example-queue"
  fifo_queue                    = true
  content_based_deduplication   = true
  delay_seconds                 = 5
  message_retention_seconds     = 1209600
  visibility_timeout_seconds    = 45
  tags = {
    Environment = "Production"
    Owner       = "DevOps"
  }
}
```

---

### **Features**

- **FIFO or Standard queues**:
  - Option to enable content-based deduplication for FIFO queues.
- **Dead Letter Queue (DLQ)** support via `redrive_policy`.
- **Message encryption** using AWS KMS.
- Fully configurable message visibility, retention, and delivery options.

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
| `main.tf`      | Contains the SQS Queue resource definition.                   |
| `variables.tf` | Defines input variables for configuring the queue.            |
| `outputs.tf`   | Exports key attributes of the queue for use in other modules. |

---

### **Inputs**

| **Name**                            | **Description**                                                    | **Type**      | **Default** | **Required** |
| ----------------------------------- | ------------------------------------------------------------------ | ------------- | ----------- | ------------ |
| `name`                              | Human-readable name of the queue.                                  | `string`      | N/A         | Yes          |
| `fifo_queue`                        | Boolean indicating if the queue is FIFO.                           | `bool`        | `false`     | No           |
| `content_based_deduplication`       | Enables content-based deduplication for FIFO queues.               | `bool`        | `false`     | No           |
| `delay_seconds`                     | The time (in seconds) to delay message delivery.                   | `number`      | `0`         | No           |
| `max_message_size`                  | Maximum size of a message in bytes.                                | `number`      | `262144`    | No           |
| `message_retention_seconds`         | How long messages are retained in the queue (in seconds).          | `number`      | `345600`    | No           |
| `receive_wait_time_seconds`         | Time for ReceiveMessage calls to wait (long polling).              | `number`      | `0`         | No           |
| `redrive_policy`                    | JSON policy for Dead Letter Queue (DLQ) setup.                     | `string`      | `""`        | No           |
| `visibility_timeout_seconds`        | Visibility timeout for the queue (in seconds).                     | `number`      | `30`        | No           |
| `kms_master_key_id`                 | AWS KMS key ID for message encryption.                             | `string`      | `null`      | No           |
| `kms_data_key_reuse_period_seconds` | Time (in seconds) for reusing data keys for encryption/decryption. | `number`      | `300`       | No           |
| `tags`                              | Key-value map of resource tags.                                    | `map(string)` | `{}`        | No           |

---

### **Outputs**

| **Name** | **Description**                   |
| -------- | --------------------------------- |
| `id`     | The URL of the created SQS queue. |
| `arn`    | The ARN of the SQS queue.         |
| `name`   | The name of the SQS queue.        |

---

### **Example Usages**

#### Standard Queue

```hcl
module "standard_queue" {
  source = "./sqs_queue"

  name                      = "standard-queue"
  delay_seconds             = 10
  message_retention_seconds = 1209600
}
```

#### FIFO Queue with Encryption

```hcl
module "fifo_queue_encrypted" {
  source = "./sqs_queue"

  name                          = "fifo-queue"
  fifo_queue                    = true
  content_based_deduplication   = true
  kms_master_key_id             = "arn:aws:kms:us-east-1:123456789012:key/example-key-id"
}
```

#### Queue with Dead Letter Queue (DLQ)

```hcl
module "queue_with_dlq" {
  source = "./sqs_queue"

  name           = "queue-with-dlq"
  redrive_policy = jsonencode({
    deadLetterTargetArn = "arn:aws:sqs:us-east-1:123456789012:dead-letter-queue"
    maxReceiveCount     = 5
  })
}
```

---

### **Authors**

Maintained by [David Essien](https://davidessien.com).

---

### **License**

This project is licensed under the MIT License.
