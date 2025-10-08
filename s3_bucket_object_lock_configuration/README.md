# AWS Terraform Module: S3 Bucket Object Lock Configuration

This Terraform module provisions an **AWS S3 Bucket Object Lock Configuration** resource, enabling Write-Once-Read-Many (WORM) protection for S3 objects to prevent deletion or modification during a retention period.

---

### **Usage**

#### Basic Object Lock Configuration Example

```hcl
module "s3_object_lock_basic" {
  source = "./modules/s3_bucket_object_lock"

  bucket = "my-sensitive-bucket"

  rule = {
    default_retention = {
      mode = "COMPLIANCE"
      days = 7
    }
  }
}
```

#### Governance Mode with Years Retention Example

```hcl
module "s3_object_lock_governance" {
  source = "./modules/s3_bucket_object_lock"

  bucket = "my-governance-bucket"

  rule = {
    default_retention = {
      mode  = "GOVERNANCE"
      years = 1
    }
  }
}
```

#### Cross-Account Object Lock Example

```hcl
module "s3_object_lock_cross_account" {
  source = "./modules/s3_bucket_object_lock"

  bucket                = "cross-account-bucket"
  expected_bucket_owner = "123456789012"

  rule = {
    default_retention = {
      mode = "COMPLIANCE"
      days = 30
    }
  }
}
```

#### Complete Setup with Prerequisites Example

```hcl
# S3 Bucket
resource "aws_s3_bucket" "example" {
  bucket = "my-object-lock-bucket"
}

# Versioning MUST be enabled before Object Lock
resource "aws_s3_bucket_versioning" "example" {
  bucket = aws_s3_bucket.example.id

  versioning_configuration {
    status = "Enabled"
  }
}

# Object Lock Configuration
module "s3_object_lock" {
  source = "./modules/s3_bucket_object_lock"
  bucket = aws_s3_bucket.example.id

  rule = {
    default_retention = {
      mode = "COMPLIANCE"
      days = 5
    }
  }

  depends_on = [aws_s3_bucket_versioning.example]
}
```

---

### **Features**

- Configures S3 Object Lock for Write-Once-Read-Many (WORM) protection
- Supports both COMPLIANCE and GOVERNANCE retention modes
- Configures retention periods in days or years
- Handles cross-account bucket ownership scenarios
- Includes comprehensive input validation
- Ensures proper dependency management with versioning

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

| **File**       | **Description**                                                 |
| -------------- | --------------------------------------------------------------- |
| `main.tf`      | Defines the AWS S3 bucket Object Lock configuration resource.   |
| `variables.tf` | Specifies input variables with comprehensive validation rules.  |
| `outputs.tf`   | Exports the unique identifier of the Object Lock configuration. |
| `README.md`    | This documentation file.                                        |

---

### **Inputs**

| **Name**                | **Description**                                                            | **Type**                                                                                                                                     | **Default** | **Required** |
| ----------------------- | -------------------------------------------------------------------------- | -------------------------------------------------------------------------------------------------------------------------------------------- | ----------- | ------------ |
| `bucket`                | The name of the bucket to configure Object Lock for.                       | `string`                                                                                                                                     | N/A         | Yes          |
| `expected_bucket_owner` | The account ID of the expected bucket owner (for cross-account scenarios). | `string`                                                                                                                                     | `null`      | No           |
| `object_lock_enabled`   | Indicates whether this bucket has an Object Lock configuration enabled.    | `string`                                                                                                                                     | `"Enabled"` | No           |
| `rule`                  | Configuration block for specifying the Object Lock rule.                   | <pre>object({<br> default_retention = object({<br> days = optional(number)<br> mode = string<br> years = optional(number)<br> })<br>})</pre> | `null`      | No           |

#### Rule Configuration

| **Parameter**       | **Description**                                                                    | **Required** |
| ------------------- | ---------------------------------------------------------------------------------- | ------------ |
| `default_retention` | Configuration block for default Object Lock retention settings.                    | Yes          |
| `days`              | Number of days for the default retention period (required if years not specified). | Conditional  |
| `mode`              | Default Object Lock retention mode. Valid values: `COMPLIANCE`, `GOVERNANCE`.      | Yes          |
| `years`             | Number of years for the default retention period (required if days not specified). | Conditional  |

---

### **Outputs**

| **Name** | **Description**                                                                      |
| -------- | ------------------------------------------------------------------------------------ |
| `id`     | The bucket or bucket and expected_bucket_owner separated by a comma (,) if provided. |

---

### **Critical Configuration Requirements**

#### Prerequisites

- **Bucket Versioning**: Object Lock requires S3 Versioning to be **enabled** on the bucket before configuration
- **Irreversible Setting**: Once you enable Object Lock on a bucket, you **cannot disable it** later

#### Retention Mode Differences

- **COMPLIANCE**: No one can overwrite or delete the object version, not even the root user
- **GOVERNANCE**: Most users cannot delete the object, but users with `s3:BypassGovernanceRetention` permission can override with explicit governance bypass

#### Important Notes

- The `token` parameter is deprecated and no longer needed
- Object Lock cannot be used with S3 directory buckets
- Buckets with Object Lock enabled cannot be used as destination buckets for S3 server access logs
- Object Lock can be enabled on both new and existing buckets

---

### **Examples**

#### Compliance Mode for Regulatory Requirements

```hcl
module "s3_object_lock_compliance" {
  source = "./modules/s3_bucket_object_lock"

  bucket = "financial-records-bucket"

  rule = {
    default_retention = {
      mode  = "COMPLIANCE"
      years = 7
    }
  }
}
```

#### Governance Mode for Data Governance

```hcl
module "s3_object_lock_governance" {
  source = "./modules/s3_bucket_object_lock"

  bucket = "data-lake-bucket"

  rule = {
    default_retention = {
      mode = "GOVERNANCE"
      days = 90
    }
  }
}
```

#### Integration with S3 Bucket Module

```hcl
# Your existing S3 bucket module
module "s3_bucket" {
  source = "./modules/s3_bucket"
  bucket = "my-secure-bucket"
}

# Versioning configuration
resource "aws_s3_bucket_versioning" "secure_bucket" {
  bucket = module.s3_bucket.id

  versioning_configuration {
    status = "Enabled"
  }
}

# Object Lock configuration
module "s3_object_lock" {
  source = "./modules/s3_bucket_object_lock"
  bucket = module.s3_bucket.id

  rule = {
    default_retention = {
      mode = "COMPLIANCE"
      days = 30
    }
  }

  depends_on = [aws_s3_bucket_versioning.secure_bucket]
}
```

---

### **Security Considerations**

- **COMPLIANCE mode** should be used for regulatory requirements where no exceptions are allowed
- **GOVERNANCE mode** provides flexibility for legitimate business needs while maintaining protection
- Consider the retention period carefully as it cannot be reduced once set
- Ensure proper IAM policies are in place for governance bypass when using GOVERNANCE mode
- Test Object Lock configurations in non-production environments first

---

### **Authors**

Maintained by [Your Name/Team].

---

### **License**

This project is licensed under the MIT License.
