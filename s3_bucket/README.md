# AWS Terraform Module: S3 Bucket

This Terraform module provisions an **AWS S3 Bucket** resource following current AWS provider best practices. It creates a basic S3 bucket with configurable naming, destruction policies, Object Lock, and tagging.

---

### **Important Migration Notice**

This module uses the **modern AWS S3 bucket implementation** (AWS provider ≥4.0) where most bucket configurations are managed through separate resources. The following configurations should **NOT** be used with this module and require separate resources:

- ❌ ACL configurations → Use `aws_s3_bucket_acl`
- ❌ Versioning → Use `aws_s3_bucket_versioning`
- ❌ Encryption → Use `aws_s3_bucket_server_side_encryption_configuration`
- ❌ Lifecycle rules → Use `aws_s3_bucket_lifecycle_configuration`
- ❌ CORS rules → Use `aws_s3_bucket_cors_configuration`
- ❌ Website hosting → Use `aws_s3_bucket_website_configuration`
- ❌ Bucket policies → Use `aws_s3_bucket_policy`
- ❌ Logging → Use `aws_s3_bucket_logging`
- ❌ Replication → Use `aws_s3_bucket_replication_configuration`
- ❌ Object Lock → Use `aws_s3_bucket_object_lock_configuration` (for existing buckets)

---

### **Usage**

#### Basic Bucket Example

```hcl
module "s3_bucket_basic" {
  source = "./modules/s3_bucket"

  bucket = "my-application-bucket"
  tags = {
    Environment = "production"
    Project     = "web-app"
  }
}
```

#### Force Destroy Enabled Example

```hcl
module "s3_bucket_force_destroy" {
  source = "./modules/s3_bucket"

  bucket        = "temp-data-bucket"
  force_destroy = true
  tags = {
    Purpose = "temporary-storage"
  }
}
```

#### Object Lock Enabled Example (New Buckets Only)

```hcl
module "s3_bucket_object_lock" {
  source = "./modules/s3_bucket"

  bucket              = "compliance-bucket"
  object_lock_enabled = true
  tags = {
    Compliance = "hipaa"
    Retention  = "7-years"
  }
}
```

#### Bucket with Prefix Example

```hcl
module "s3_bucket_prefix" {
  source = "./modules/s3_bucket"

  bucket_prefix = "my-app-logs-"
  force_destroy = false
  tags = {
    Logs = "application"
  }
}
```

---

### **Features**

- Creates S3 buckets with configurable naming
- Supports force destroy for easy bucket deletion
- Enables Object Lock for new buckets (compliance requirements)
- Provides comprehensive tagging support
- Follows AWS provider ≥4.0 best practices
- Outputs all relevant bucket attributes for integration

---

### Requirements

| Name         | Version   |
| ------------ | --------- |
| Terraform    | >= 1.13.3 |
| AWS Provider | >= 4.0.0  |

---

### Providers

| Provider | Source    | Version  |
| -------- | --------- | -------- |
| `aws`    | HashiCorp | >= 4.0.0 |

---

### **Explanation of Files**

| **File**       | **Description**                                    |
| -------------- | -------------------------------------------------- |
| `main.tf`      | Defines the core AWS S3 bucket resource            |
| `variables.tf` | Specifies input variables with validation          |
| `outputs.tf`   | Exports bucket attributes for use in other modules |
| `README.md`    | This documentation file                            |

---

### **Inputs**

| **Name**              | **Description**                                                                         | **Type**      | **Default** | **Required** |
| --------------------- | --------------------------------------------------------------------------------------- | ------------- | ----------- | ------------ |
| `bucket`              | Name of the bucket. If omitted, Terraform will assign a random, unique name             | `string`      | `null`      | No           |
| `bucket_prefix`       | Creates a unique bucket name beginning with the specified prefix. Conflicts with bucket | `string`      | `null`      | No           |
| `force_destroy`       | Boolean that indicates all objects should be deleted from the bucket when destroyed     | `bool`        | `false`     | No           |
| `object_lock_enabled` | Indicates whether this bucket has an Object Lock configuration enabled                  | `bool`        | `false`     | No           |
| `tags`                | Map of tags to assign to the bucket                                                     | `map(string)` | `{}`        | No           |

---

### **Outputs**

| **Name**                      | **Description**                                                |
| ----------------------------- | -------------------------------------------------------------- |
| `id`                          | Name of the bucket                                             |
| `arn`                         | ARN of the bucket                                              |
| `bucket_domain_name`          | Bucket domain name                                             |
| `bucket_regional_domain_name` | The bucket region-specific domain name                         |
| `hosted_zone_id`              | Route 53 Hosted Zone ID for this bucket's region               |
| `region`                      | AWS region this bucket resides in                              |
| `tags_all`                    | Map of tags assigned to the resource, including inherited ones |

---

### **Critical Configuration Notes**

#### Bucket Naming Rules

- **Bucket vs Prefix**: Use either `bucket` or `bucket_prefix`, not both
- **DNS Compliance**: Bucket names must be DNS-compliant - lowercase alphanumeric, hyphens, periods
- **Length**: 3-63 characters total
- **Global Uniqueness**: Bucket names must be globally unique across all AWS accounts

#### Object Lock Considerations

- **New Buckets Only**: Object Lock can only be enabled for **new buckets** - existing buckets require AWS Support to enable Object Lock
- **Automatic Versioning**: Enabling Object Lock automatically enables versioning for the bucket
- **Irreversible**: Once enabled, Object Lock cannot be disabled

#### Force Destroy Warning

- **Data Loss**: Setting `force_destroy = true` allows Terraform to delete buckets with objects, resulting in **permanent data loss**
- **Use Carefully**: Only use for temporary buckets or when you have proper data backup procedures

---

### **Examples**

#### Production Bucket with Proper Safeguards

```hcl
module "production_bucket" {
  source = "./modules/s3_bucket"

  bucket        = "company-production-data"
  force_destroy = false  # Protect against accidental deletion
  tags = {
    Environment = "production"
    Owner       = "data-team"
    CostCenter  = "12345"
  }
}
```

#### Integration with Other S3 Configuration Modules

```hcl
# Basic bucket
module "s3_bucket" {
  source = "./modules/s3_bucket"
  bucket = "my-fully-configured-bucket"
}

# Versioning configuration
resource "aws_s3_bucket_versioning" "this" {
  bucket = module.s3_bucket.id
  versioning_configuration {
    status = "Enabled"
  }
}

# Encryption configuration
resource "aws_s3_bucket_server_side_encryption_configuration" "this" {
  bucket = module.s3_bucket.id
  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

# Lifecycle configuration
resource "aws_s3_bucket_lifecycle_configuration" "this" {
  bucket = module.s3_bucket.id
  rule {
    id     = "auto-archive"
    status = "Enabled"
    transition {
      days          = 90
      storage_class = "GLACIER"
    }
  }
}
```

---

### **Best Practices**

1. **Use Descriptive Names**: Choose bucket names that indicate purpose and environment
2. **Avoid Force Destroy**: Set `force_destroy = false` for production buckets to prevent data loss
3. **Enable Versioning**: Use `aws_s3_bucket_versioning` resource for data protection
4. **Implement Encryption**: Always configure server-side encryption
5. **Use Tags**: Comprehensive tagging for cost allocation and management
6. **Consider Object Lock**: For compliance buckets, enable Object Lock during creation

---

### **Authors**

Maintained by [Your Name/Team].

---

### **License**

This project is licensed under the MIT License.
