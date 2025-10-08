# AWS Terraform Module: S3 Bucket Lifecycle Configuration

This Terraform module provisions an **AWS S3 Bucket Lifecycle Configuration** resource, enabling automated management of object lifecycles including transitions between storage classes and expiration policies.

---

### **Usage**

#### Basic Lifecycle Configuration Example

```hcl
module "s3_lifecycle_basic" {
  source = "./modules/s3_bucket_lifecycle"

  bucket = "my-bucket"

  rules = [
    {
      id     = "cleanup-temp"
      status = "Enabled"
      filter = {
        prefix = "temp/"
      }
      expiration = {
        days = 7
      }
    }
  ]
}
```

#### Advanced Lifecycle with Multiple Rules Example

```hcl
module "s3_lifecycle_advanced" {
  source = "./modules/s3_bucket_lifecycle"

  bucket = "my-advanced-bucket"

  rules = [
    {
      id     = "log-retention"
      status = "Enabled"
      filter = {
        prefix = "logs/"
      }
      transitions = [
        {
          days          = 30
          storage_class = "STANDARD_IA"
        },
        {
          days          = 60
          storage_class = "GLACIER"
        }
      ]
      expiration = {
        days = 365
      }
    },
    {
      id     = "incomplete-uploads"
      status = "Enabled"
      filter = {}
      abort_incomplete_multipart_upload = {
        days_after_initiation = 3
      }
    }
  ]
}
```

#### Version-Enabled Bucket Lifecycle Example

```hcl
module "s3_lifecycle_versioned" {
  source = "./modules/s3_bucket_lifecycle"

  bucket = "my-versioned-bucket"

  rules = [
    {
      id     = "version-management"
      status = "Enabled"
      filter = {
        prefix = "documents/"
      }
      noncurrent_version_transitions = [
        {
          noncurrent_days = 30
          storage_class   = "STANDARD_IA"
        }
      ]
      noncurrent_version_expiration = {
        noncurrent_days = 90
      }
    }
  ]
}
```

---

### **Features**

- Configures comprehensive S3 bucket lifecycle policies
- Supports multiple lifecycle rules per configuration
- Handles all filter types: prefix, tags, object size, and combinations
- Manages both current and noncurrent object version lifecycles
- Supports storage class transitions and expiration policies
- Includes proper conflict resolution for mutually exclusive parameters
- Validates all inputs for correctness and AWS compatibility

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

| **File**       | **Description**                                                                 |
| -------------- | ------------------------------------------------------------------------------- |
| `main.tf`      | Defines the AWS S3 bucket lifecycle configuration resource with dynamic blocks. |
| `variables.tf` | Specifies input variables with comprehensive validation rules.                  |
| `outputs.tf`   | Exports the unique identifier of the lifecycle configuration.                   |

---

### **Inputs**

| **Name**                | **Description**                                                            | **Type**                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       | **Default** | **Required** |
| ----------------------- | -------------------------------------------------------------------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ----------- | ------------ |
| `bucket`                | The name of the bucket for the lifecycle configuration.                    | `string`                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       | N/A         | Yes          |
| `expected_bucket_owner` | The account ID of the expected bucket owner (for cross-account scenarios). | `string`                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       | `null`      | No           |
| `rules`                 | List of lifecycle rules to apply to the bucket.                            | <pre>list(object({<br> id = string<br> status = string<br> filter = optional(object({<br> prefix = optional(string)<br> object_size_greater_than = optional(number)<br> object_size_less_than = optional(number)<br> tag = optional(object({<br> key = string<br> value = string<br> }))<br> and = optional(object({<br> prefix = optional(string)<br> object_size_greater_than = optional(number)<br> object_size_less_than = optional(number)<br> tags = optional(map(string))<br> }))<br> }))<br> expiration = optional(object({<br> date = optional(string)<br> days = optional(number)<br> expired_object_delete_marker = optional(bool)<br> }))<br> transitions = optional(list(object({<br> date = optional(string)<br> days = optional(number)<br> storage_class = string<br> })), [])<br> noncurrent_version_expiration = optional(object({<br> newer_noncurrent_versions = optional(number)<br> noncurrent_days = number<br> }))<br> noncurrent_version_transitions = optional(list(object({<br> newer_noncurrent_versions = optional(number)<br> noncurrent_days = number<br> storage_class = string<br> })), [])<br> abort_incomplete_multipart_upload = optional(object({<br> days_after_initiation = number<br> }))<br>}))</pre> | `[]`        | No           |

#### Rule Configuration

| **Parameter**                       | **Description**                                                 | **Required** |
| ----------------------------------- | --------------------------------------------------------------- | ------------ |
| `id`                                | Unique identifier for the rule (1-255 alphanumeric characters). | Yes          |
| `status`                            | Whether the rule is active (`Enabled` or `Disabled`).           | Yes          |
| `filter`                            | Configuration to identify objects the rule applies to.          | No           |
| `expiration`                        | Configuration for object expiration.                            | No           |
| `transitions`                       | List of storage class transition rules.                         | No           |
| `noncurrent_version_expiration`     | Configuration for noncurrent version expiration.                | No           |
| `noncurrent_version_transitions`    | List of noncurrent version transition rules.                    | No           |
| `abort_incomplete_multipart_upload` | Configuration for aborting incomplete multipart uploads.        | No           |

#### Valid Storage Classes

- `GLACIER`
- `STANDARD_IA`
- `ONEZONE_IA`
- `INTELLIGENT_TIERING`
- `DEEP_ARCHIVE`
- `GLACIER_IR`

---

### **Outputs**

| **Name** | **Description**                                                                      |
| -------- | ------------------------------------------------------------------------------------ |
| `id`     | The bucket or bucket and expected_bucket_owner separated by a comma (,) if provided. |

---

### **Important Configuration Notes**

#### Single Configuration Limit

- **Critical**: S3 buckets only support a **single lifecycle configuration** . Declaring multiple `aws_s3_bucket_lifecycle_configuration` resources for the same bucket will cause perpetual differences in your Terraform state.

#### Filter Configuration Rules

- The `filter` block must either be empty (`filter {}`) to apply to all objects, or specify exactly one of: `prefix`, `tag`, `object_size_greater_than`, or `object_size_less_than`
- The `and` block allows combining multiple filter conditions with logical AND
- **Deprecation Notice**: The `prefix` parameter at the rule level is deprecated; use `filter.prefix` instead

#### Conflict Management

- **Expiration**: Only one of `date`, `days`, or `expired_object_delete_marker` can be specified
- **Transitions**: Only one of `date` or `days` should be specified in transition blocks
- **Object Size**: Amazon S3 applies a default behavior that prevents objects smaller than 128 KB from being transitioned unless explicitly overridden with `object_size_greater_than` filter

#### Versioning Considerations

- Use `noncurrent_version_expiration` and `noncurrent_version_transition` for version-enabled buckets
- These parameters only work when bucket versioning is enabled
- For non-versioned buckets, use regular `expiration` and `transition` blocks

#### Storage Class Requirements

- Different storage classes have different minimum storage duration requirements
- Transitioning objects before minimum durations may incur charges
- Valid values depend on the storage class being transitioned to

#### Multipart Upload Cleanup

- `abort_incomplete_multipart_upload` helps optimize costs by cleaning up incomplete uploads
- Typically set between 1-7 days depending on use case

---

### **Examples**

#### Cost Optimization for Log Files

```hcl
module "s3_lifecycle_logs" {
  source = "./modules/s3_bucket_lifecycle"

  bucket = "company-logs-bucket"

  rules = [
    {
      id     = "log-rotation"
      status = "Enabled"
      filter = {
        prefix = "application-logs/"
      }
      transitions = [
        {
          days          = 30
          storage_class = "STANDARD_IA"
        },
        {
          days          = 60
          storage_class = "GLACIER"
        }
      ]
      expiration = {
        days = 365
      }
      abort_incomplete_multipart_upload = {
        days_after_initiation = 2
      }
    }
  ]
}
```

#### Compliance Data Retention

```hcl
module "s3_lifecycle_compliance" {
  source = "./modules/s3_bucket_lifecycle"

  bucket = "compliance-data-bucket"

  rules = [
    {
      id     = "7-year-retention"
      status = "Enabled"
      filter = {
        and = {
          prefix = "financial-records/"
          tags = {
            Retention = "7Years"
            Department = "Finance"
          }
        }
      }
      transitions = [
        {
          days          = 90
          storage_class = "DEEP_ARCHIVE"
        }
      ]
      expiration = {
        days = 2555 # Approximately 7 years
      }
    }
  ]
}
```

#### Integration with S3 Bucket Module

```hcl
# Your existing S3 bucket module
module "s3_bucket" {
  source = "./modules/s3_bucket"
  bucket = "my-application-bucket"
}

# Lifecycle configuration
module "s3_lifecycle" {
  source = "./modules/s3_bucket_lifecycle"
  bucket = module.s3_bucket.id

  rules = [
    {
      id     = "default-policy"
      status = "Enabled"
      filter = {}
      transitions = [
        {
          days          = 30
          storage_class = "STANDARD_IA"
        }
      ]
      abort_incomplete_multipart_upload = {
        days_after_initiation = 3
      }
    }
  ]
}
```

---

### **Authors**

Maintained by [Your Name/Team].

---

### **License**

This project is licensed under the MIT License.
