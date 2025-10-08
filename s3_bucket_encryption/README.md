# AWS Terraform Module: S3 Bucket Server-Side Encryption Configuration

This Terraform module provisions an **AWS S3 Bucket Server-Side Encryption Configuration** resource, enabling data protection at rest for S3 buckets using AWS-managed or customer-managed encryption keys.

---

### **Usage**

#### Basic SSE-S3 Encryption (AWS Managed Keys) Example

```hcl
module "s3_encryption_basic" {
  source = "./modules/s3_bucket_encryption"

  bucket        = "my-bucket"
  sse_algorithm = "AES256"
}
```

#### SSE-KMS with Custom KMS Key Example

```hcl
module "s3_encryption_kms" {
  source = "./modules/s3_bucket_encryption"

  bucket            = "my-sensitive-bucket"
  sse_algorithm     = "aws:kms"
  kms_master_key_id = aws_kms_key.my_key.arn
  bucket_key_enabled = true
}
```

#### Dual-Layer SSE-KMS (DSSE-KMS) Example

```hcl
module "s3_encryption_dsse" {
  source = "./modules/s3_bucket_encryption"

  bucket            = "my-high-security-bucket"
  sse_algorithm     = "aws:kms:dsse"
  kms_master_key_id = aws_kms_key.my_dsse_key.arn
}
```

#### Cross-Account Encryption Configuration Example

```hcl
module "s3_encryption_cross_account" {
  source = "./modules/s3_bucket_encryption"

  bucket                = "cross-account-bucket"
  sse_algorithm         = "aws:kms"
  kms_master_key_id     = "arn:aws:kms:us-east-1:123456789012:key/abcd1234-5678-90ef-ghij-klmnopqrstuv"
  expected_bucket_owner = "123456789012"
}
```

---

### **Features**

- Configures server-side encryption for S3 buckets using multiple encryption options
- Supports SSE-S3 (AWS managed keys), SSE-KMS, and dual-layer SSE-KMS (DSSE-KMS)
- Enables S3 Bucket Keys for cost optimization with SSE-KMS
- Handles cross-account bucket ownership scenarios
- Includes comprehensive input validation for encryption parameters
- Provides flexible configuration for all AWS encryption options

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

| **File**       | **Description**                                                          |
| -------------- | ------------------------------------------------------------------------ |
| `main.tf`      | Defines the AWS S3 bucket server-side encryption configuration resource. |
| `variables.tf` | Specifies input variables with comprehensive validation rules.           |
| `outputs.tf`   | Exports the unique identifier of the encryption configuration.           |
| `README.md`    | This documentation file.                                                 |

---

### **Inputs**

| **Name**                | **Description**                                                                                                  | **Type** | **Default** | **Required** |
| ----------------------- | ---------------------------------------------------------------------------------------------------------------- | -------- | ----------- | ------------ |
| `bucket`                | The name of the bucket to configure server-side encryption for.                                                  | `string` | N/A         | Yes          |
| `sse_algorithm`         | Server-side encryption algorithm to use. Valid values: `AES256`, `aws:kms`, `aws:kms:dsse`.                      | `string` | `"AES256"`  | No           |
| `kms_master_key_id`     | AWS KMS master key ID used for SSE-KMS encryption. Required when `sse_algorithm` is `aws:kms` or `aws:kms:dsse`. | `string` | `null`      | No           |
| `bucket_key_enabled`    | Whether to use Amazon S3 Bucket Keys for SSE-KMS to reduce AWS KMS request costs.                                | `bool`   | `false`     | No           |
| `expected_bucket_owner` | The account ID of the expected bucket owner (for cross-account scenarios).                                       | `string` | `null`      | No           |

---

### **Outputs**

| **Name** | **Description**                                                                      |
| -------- | ------------------------------------------------------------------------------------ |
| `id`     | The bucket or bucket and expected_bucket_owner separated by a comma (,) if provided. |

---

### **Important Configuration Notes**

#### Default Encryption Behavior

- **AWS Default**: All new S3 buckets now have **SSE-S3 encryption enabled by default** (AES-256) at no additional cost
- **Module Default**: This module defaults to `AES256` (SSE-S3) to maintain consistency with AWS defaults
- **Reset on Destroy**: Destroying this resource resets the bucket to Amazon S3's **default SSE-S3 encryption**

#### KMS Key Configuration

- **SSE-KMS Requirement**: When using `aws:kms` or `aws:kms:dsse` algorithms, you must provide a `kms_master_key_id`
- **AWS Managed Key**: If no KMS key is specified with `aws:kms` algorithm, AWS uses the default `aws/s3` key, but explicit specification is recommended for cross-account scenarios
- **Cross-Account Consideration**: For cross-account operations, use **customer-managed KMS keys** and specify full key ARNs

#### Cost Optimization

- **Bucket Keys**: Enable `bucket_key_enabled = true` for SSE-KMS to **reduce AWS KMS request costs** by up to 99% by using a bucket-level key
- **SSE-S3**: Uses AWS-managed keys at **no additional cost** beyond standard S3 storage

#### Compatibility Notes

- **S3 Access Logging**: Buckets with **SSE-KMS default encryption cannot be used as destination buckets for server access logging** - only SSE-S3 is supported for log destinations
- **Provider Version**: Ensure you're using AWS Provider `>= 4.0` as earlier versions had different implementation approaches

---

### **Examples**

#### Regulatory Compliance with KMS

```hcl
resource "aws_kms_key" "compliance_key" {
  description             = "KMS key for regulatory compliance data"
  deletion_window_in_days = 30
  enable_key_rotation     = true
}

module "s3_encryption_compliance" {
  source = "./modules/s3_bucket_encryption"

  bucket             = "compliance-data-bucket"
  sse_algorithm      = "aws:kms"
  kms_master_key_id  = aws_kms_key.compliance_key.arn
  bucket_key_enabled = true
}
```

#### Cost-Optimized Archive Storage

```hcl
module "s3_encryption_archive" {
  source = "./modules/s3_bucket_encryption"

  bucket        = "company-archive-bucket"
  sse_algorithm = "AES256"  # SSE-S3 for cost efficiency
}
```

#### Integration with S3 Bucket Module

```hcl
# Your existing S3 bucket module
module "s3_bucket" {
  source = "./modules/s3_bucket"
  bucket = "my-application-bucket"
}

# Encryption configuration
module "s3_encryption" {
  source = "./modules/s3_bucket_encryption"
  bucket = module.s3_bucket.id

  sse_algorithm     = "aws:kms"
  kms_master_key_id = "alias/aws/s3"  # Using AWS managed KMS key
  bucket_key_enabled = true
}
```

---

### **Security Considerations**

- **SSE-S3**: Uses AWS-managed keys - simplest option with no key management overhead
- **SSE-KMS**: Provides audit trails and granular control through AWS KMS
- **DSSE-KMS**: Provides dual-layer encryption for highest security requirements
- **Bucket Policies**: Consider adding bucket policies to enforce encryption on object uploads
- **Key Rotation**: For SSE-KMS with customer-managed keys, enable automatic key rotation

---

### **Authors**

Maintained by [Your Name/Team].

---

### **License**

This project is licensed under the MIT License.
