# AWS Terraform Module: S3 Bucket Request Payment Configuration

This Terraform module provisions an **AWS S3 Bucket Request Payment Configuration** resource, enabling Requester Pays configuration for S3 buckets where requesters pay for download and request fees instead of the bucket owner.

---

### **Usage**

#### Basic Requester Pays Configuration Example

```hcl
module "s3_request_payment" {
  source = "./modules/s3_bucket_request_payment"

  bucket = "my-requester-pays-bucket"
  payer  = "Requester"
}
```

#### Bucket Owner Pays Configuration Example

```hcl
module "s3_request_payment_owner" {
  source = "./modules/s3_bucket_request_payment"

  bucket = "my-regular-bucket"
  payer  = "BucketOwner"
}
```

#### Cross-Account Request Payment Configuration Example

```hcl
module "s3_request_payment_cross_account" {
  source = "./modules/s3_bucket_request_payment"

  bucket                = "cross-account-bucket"
  payer                 = "Requester"
  expected_bucket_owner = "123456789012"
}
```

#### Integration with S3 Bucket Module Example

```hcl
# Your existing S3 bucket module
module "s3_bucket" {
  source = "./modules/s3_bucket"
  bucket = "my-application-bucket"
}

# Request payment configuration
module "s3_request_payment" {
  source = "./modules/s3_bucket_request_payment"
  bucket = module.s3_bucket.id
  payer  = "Requester"
}
```

---

### **Features**

- Configures Requester Pays buckets where downloaders pay transfer costs
- Supports both BucketOwner and Requester payment modes
- Handles cross-account bucket ownership scenarios
- Simple, focused implementation with comprehensive validation
- Easy integration with existing S3 bucket modules

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

| **File**       | **Description**                                                     |
| -------------- | ------------------------------------------------------------------- |
| `main.tf`      | Defines the AWS S3 bucket request payment configuration resource.   |
| `variables.tf` | Specifies input variables with comprehensive validation rules.      |
| `outputs.tf`   | Exports the unique identifier of the request payment configuration. |
| `README.md`    | This documentation file.                                            |

---

### **Inputs**

| **Name**                | **Description**                                                                                 | **Type** | **Default** | **Required** |
| ----------------------- | ----------------------------------------------------------------------------------------------- | -------- | ----------- | ------------ |
| `bucket`                | The name of the bucket to configure request payment for.                                        | `string` | N/A         | Yes          |
| `payer`                 | Specifies who pays for the download and request fees. Valid values: `BucketOwner`, `Requester`. | `string` | N/A         | Yes          |
| `expected_bucket_owner` | The account ID of the expected bucket owner (for cross-account scenarios).                      | `string` | `null`      | No           |

---

### **Outputs**

| **Name** | **Description**                                                                      |
| -------- | ------------------------------------------------------------------------------------ |
| `id`     | The bucket or bucket and expected_bucket_owner separated by a comma (,) if provided. |

---

### **Important Configuration Notes**

#### Requester Pays Overview

- **BucketOwner**: Default mode where the bucket owner pays all costs
- **Requester**: Requesters pay for data downloads and requests, reducing bucket owner costs

#### Critical Considerations

- **Account Requirement**: Both the bucket owner and the requester must be in the same AWS account
- **Bucket-Level Setting**: Configuration applies to the entire bucket, not individual objects
- **Configuration Time**: Changes may take a few minutes to take effect
- **Reset on Destroy**: Destroying this resource resets the bucket's payer to the default (`BucketOwner`)

#### Presigned URL Warning

Bucket owners should carefully consider before configuring Requester Pays when using presigned URLs, especially with long lifetimes. The bucket owner is charged each time a requester uses a presigned URL that uses the bucket owner's credentials .

#### Use Case Pattern

Typically, you would use `BucketOwner` when uploading data to the S3 bucket, then set the value to `Requester` before publishing the objects in the bucket .

---

### **Examples**

#### Data Sharing with Cost Management

```hcl
module "s3_data_sharing" {
  source = "./modules/s3_bucket_request_payment"

  bucket = "public-dataset-bucket"
  payer  = "Requester"
}
```

#### Multi-Environment Configuration

```hcl
# Development environment - owner pays
module "s3_request_payment_dev" {
  source = "./modules/s3_bucket_request_payment"

  bucket = "dev-bucket"
  payer  = "BucketOwner"
}

# Production environment - requesters pay
module "s3_request_payment_prod" {
  source = "./modules/s3_bucket_request_payment"

  bucket = "prod-bucket"
  payer  = "Requester"
}
```

#### Complete Infrastructure Setup

```hcl
# S3 Bucket
resource "aws_s3_bucket" "data_bucket" {
  bucket = "company-data-bucket"
}

# Versioning for data protection
resource "aws_s3_bucket_versioning" "data_bucket" {
  bucket = aws_s3_bucket.data_bucket.id

  versioning_configuration {
    status = "Enabled"
  }
}

# Requester Pays configuration
module "s3_request_payment" {
  source = "./modules/s3_bucket_request_payment"
  bucket = aws_s3_bucket.data_bucket.id
  payer  = "Requester"
}
```

---

### **Security Considerations**

- Use Requester Pays for publicly accessible datasets to avoid unexpected bandwidth costs
- Monitor usage patterns when enabling Requester Pays
- Consider IAM policies to control who can enable/disable this configuration
- Be cautious with presigned URLs as noted in the warnings above

---

### **Authors**

Maintained by [Your Name/Team].

---

### **License**

This project is licensed under the MIT License.
