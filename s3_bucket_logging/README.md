# AWS Terraform Module: S3 Bucket Logging

This Terraform module provisions an **AWS S3 Bucket Logging** resource, enabling server access logging for S3 buckets to track requests and monitor access patterns.

---

### **Usage**

#### Basic Logging Configuration Example

```hcl
module "s3_bucket_logging_basic" {
  source = "./modules/s3_bucket_logging"

  bucket        = "my-source-bucket"
  target_bucket = "my-log-bucket"
  target_prefix = "logs/"
}
```

#### Advanced Logging with Partitioned Prefix Example

```hcl
module "s3_bucket_logging_advanced" {
  source = "./modules/s3_bucket_logging"

  bucket        = "my-source-bucket"
  target_bucket = "my-log-bucket"
  target_prefix = "s3-logs/"

  target_object_key_format = {
    partitioned_prefix = {
      partition_date_source = "EventTime"
    }
  }

  source_bucket_arn  = "arn:aws:s3:::my-source-bucket"
  target_bucket_arn  = "arn:aws:s3:::my-log-bucket"
  source_account_id  = "123456789012"
}
```

#### Logging with Target Grants Example

```hcl
module "s3_bucket_logging_with_grants" {
  source = "./modules/s3_bucket_logging"

  bucket        = "my-sensitive-bucket"
  target_bucket = "my-log-bucket"
  target_prefix = "audit-logs/"

  target_grants = [
    {
      permission = "FULL_CONTROL"
      grantee = {
        type = "CanonicalUser"
        id   = "abc123def456ghi789"
      }
    },
    {
      permission = "READ"
      grantee = {
        type = "Group"
        uri  = "http://acs.amazonaws.com/groups/s3/LogDelivery"
      }
    }
  ]
}
```

---

### **Features**

- Configures S3 server access logging for comprehensive request tracking
- Supports both simple and partitioned log object key formats
- Provides fine-grained permissions control through target grants
- Includes automated bucket policy configuration for log delivery permissions
- Handles cross-account logging scenarios
- Implements AWS security best practices for log delivery

---

### Requirements

| Name         | Version   |
| ------------ | --------- |
| Terraform    | >= 1.13.3 |
| AWS Provider | >= 6.15.0 |

---

### Providers

| Provider | Source    | Version   |
| -------- | --------- | --------- |
| `aws`    | HashiCorp | >= 6.15.0 |

---

### **Explanation of Files**

| **File**       | **Description**                                                                   |
| -------------- | --------------------------------------------------------------------------------- |
| `main.tf`      | Defines the S3 bucket logging resource with dynamic blocks and optional policies. |
| `variables.tf` | Specifies input variables with comprehensive validation rules.                    |
| `outputs.tf`   | Exports the unique identifier of the logging configuration.                       |

---

### **Inputs**

| **Name**                     | **Description**                                                 | **Type**                                                                                                                                                                                          | **Default** | **Required** |
| ---------------------------- | --------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ----------- | ------------ |
| `bucket`                     | The name of the source bucket to enable logging for.            | `string`                                                                                                                                                                                          | N/A         | Yes          |
| `target_bucket`              | The name of the target bucket where logs will be delivered.     | `string`                                                                                                                                                                                          | N/A         | Yes          |
| `target_prefix`              | The prefix for all log object keys.                             | `string`                                                                                                                                                                                          | `""`        | No           |
| `expected_bucket_owner`      | The account ID of the expected bucket owner.                    | `string`                                                                                                                                                                                          | `null`      | No           |
| `target_grants`              | List of target grants for fine-grained permissions control.     | <pre>list(object({<br> permission = string<br> grantee = object({<br> type = string<br> email_address = optional(string)<br> id = optional(string)<br> uri = optional(string)<br> })<br>}))</pre> | `[]`        | No           |
| `target_object_key_format`   | Configuration for the target object key format.                 | <pre>object({<br> partitioned_prefix = optional(object({<br> partition_date_source = string<br> }))<br> simple_prefix = optional(object({}))<br>})</pre>                                          | `null`      | No           |
| `attach_log_delivery_policy` | Whether to attach a bucket policy for log delivery permissions. | `bool`                                                                                                                                                                                            | `true`      | No           |
| `source_bucket_arn`          | The ARN of the source bucket for policy conditions.             | `string`                                                                                                                                                                                          | `null`      | No           |
| `target_bucket_arn`          | The ARN of the target bucket for policy conditions.             | `string`                                                                                                                                                                                          | `null`      | No           |
| `source_account_id`          | The source account ID for policy conditions.                    | `string`                                                                                                                                                                                          | `null`      | No           |

#### Target Grant Configuration

| **Parameter**           | **Description**                                                                             | **Required** |
| ----------------------- | ------------------------------------------------------------------------------------------- | ------------ |
| `permission`            | Logging permissions assigned to the grantee. Valid values: `FULL_CONTROL`, `READ`, `WRITE`. | Yes          |
| `grantee`               | Configuration for the person or group being granted permissions.                            | Yes          |
| `grantee.type`          | Type of grantee. Valid values: `CanonicalUser`, `AmazonCustomerByEmail`, `Group`.           | Yes          |
| `grantee.email_address` | Email address of the grantee (required for `AmazonCustomerByEmail` type).                   | Conditional  |
| `grantee.id`            | Canonical user ID of the grantee (required for `CanonicalUser` type).                       | Conditional  |
| `grantee.uri`           | URI of the grantee group (required for `Group` type).                                       | Conditional  |

#### Key Format Options

- **Simple Prefix**: `[target_prefix][YYYY]-[MM]-[DD]-[hh]-[mm]-[ss]-[UniqueString]`
- **Partitioned Prefix**: `[target_prefix][SourceAccountId]/[SourceRegion]/[SourceBucket]/[YYYY]/[MM]/[DD]/[YYYY]-[MM]-[DD]-[hh]-[mm]-[ss]-[UniqueString]`

---

### **Outputs**

| **Name** | **Description**                                                                      |
| -------- | ------------------------------------------------------------------------------------ |
| `id`     | The bucket or bucket and expected_bucket_owner separated by a comma (,) if provided. |

---

### **Important Configuration Notes**

#### Permission Requirements

- **Critical**: The target bucket must grant `s3:PutObject` permissions to the S3 log delivery service principal `logging.s3.amazonaws.com` .
- The module includes an optional bucket policy that automatically configures these permissions when `attach_log_delivery_policy = true`.
- **Security Best Practice**: Use bucket policies instead of ACLs for granting permissions, as AWS recommends phasing out ACLs .

#### Bucket Configuration Constraints

- **Region Constraint**: The target bucket must be in the same AWS Region as the source bucket .
- **Account Constraint**: Both source and target buckets must be in the same AWS account .
- **Object Lock**: Buckets with S3 Object Lock enabled cannot be used as destination buckets for server access logs .
- **Encryption**: Default bucket encryption on the destination bucket only supports SSE-S3 (AES-256); SSE-KMS is not supported for log delivery buckets .

#### Log Delivery Considerations

- **Avoid Infinite Loops**: Do not configure a bucket to log to itself, as this creates an infinite loop of logs .
- **Cost Considerations**: While enabling server access logging has no extra charge, stored log files accrue normal storage charges .
- **Requester Pays**: The destination bucket must not have Requester Pays enabled .

#### Security Best Practices

- Use the partitioned prefix format for better log organization and easier analysis
- Implement the included bucket policy rather than relying on ACLs
- Regularly review and archive old logs to manage storage costs
- Monitor log delivery to ensure continuous security auditing

---

### **Examples**

#### Compliance and Audit Logging

```hcl
module "s3_audit_logging" {
  source = "./modules/s3_bucket_logging"

  bucket        = "financial-data-bucket"
  target_bucket = "audit-logs-bucket"
  target_prefix = "s3-access-logs/"

  target_object_key_format = {
    partitioned_prefix = {
      partition_date_source = "EventTime"
    }
  }

  # Grant security team full control over logs
  target_grants = [
    {
      permission = "FULL_CONTROL"
      grantee = {
        type = "CanonicalUser"
        id   = "security-team-user-id"
      }
    }
  ]

  source_bucket_arn  = "arn:aws:s3:::financial-data-bucket"
  target_bucket_arn  = "arn:aws:s3:::audit-logs-bucket"
  source_account_id  = "123456789012"
}
```

#### Multi-Bucket Logging to Central Bucket

```hcl
module "app_bucket_logging" {
  source = "./modules/s3_bucket_logging"

  bucket        = "application-bucket"
  target_bucket = "central-logs-bucket"
  target_prefix = "app-bucket-logs/"
}

module "web_bucket_logging" {
  source = "./modules/s3_bucket_logging"

  bucket        = "website-assets-bucket"
  target_bucket = "central-logs-bucket"
  target_prefix = "web-bucket-logs/"
}
```

#### Integration with Existing S3 Modules

```hcl
# Source bucket module
module "s3_bucket" {
  source = "./modules/s3_bucket"
  bucket = "my-application-bucket"
}

# Log bucket module
module "log_bucket" {
  source = "./modules/s3_bucket"
  bucket = "my-log-bucket"
}

# Logging configuration
module "s3_bucket_logging" {
  source = "./modules/s3_bucket_logging"

  bucket        = module.s3_bucket.id
  target_bucket = module.log_bucket.id
  target_prefix = "application-logs/"

  source_bucket_arn = module.s3_bucket.arn
  target_bucket_arn = module.log_bucket.arn
  source_account_id = "123456789012"
}
```

---

### **Authors**

Maintained by [Your Name/Team].

---

### **License**

This project is licensed under the MIT License.
