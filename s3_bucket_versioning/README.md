# AWS Terraform Module: S3 Bucket Versioning

This Terraform module provisions an **AWS S3 Bucket Versioning** resource, enabling versioning and MFA delete protection for S3 buckets to protect against accidental deletion and provide object recovery capabilities.

---

### **Usage**

#### Basic Versioning Enabled Example

```hcl
module "s3_versioning_basic" {
  source = "./modules/s3_bucket_versioning"

  bucket = "my-bucket"

  versioning_configuration = {
    status     = "Enabled"
    mfa_delete = "Disabled"
  }
}
```

#### Versioning with MFA Delete Protection Example

```hcl
module "s3_versioning_mfa" {
  source = "./modules/s3_bucket_versioning"

  bucket = "my-sensitive-bucket"
  mfa    = "arn:aws:iam::123456789012:mfa/my-mfa-device 123456"

  versioning_configuration = {
    status     = "Enabled"
    mfa_delete = "Enabled"
  }
}
```

#### Cross-Account Versioning Configuration Example

```hcl
module "s3_versioning_cross_account" {
  source = "./modules/s3_bucket_versioning"

  bucket                = "cross-account-bucket"
  expected_bucket_owner = "123456789012"

  versioning_configuration = {
    status     = "Enabled"
    mfa_delete = "Disabled"
  }
}
```

#### Versioning Suspension Example

```hcl
module "s3_versioning_suspended" {
  source = "./modules/s3_bucket_versioning"

  bucket = "my-bucket"

  versioning_configuration = {
    status     = "Suspended"
    mfa_delete = "Disabled"
  }
}
```

---

### **Features**

- Configures S3 bucket versioning to maintain multiple object versions
- Enables MFA delete protection for enhanced security
- Supports cross-account bucket ownership scenarios
- Handles all versioning states: Enabled, Suspended, and Disabled
- Includes comprehensive input validation
- Provides proper MFA device configuration support

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

| **File**       | **Description**                                                |
| -------------- | -------------------------------------------------------------- |
| `main.tf`      | Defines the AWS S3 bucket versioning resource.                 |
| `variables.tf` | Specifies input variables with comprehensive validation rules. |
| `outputs.tf`   | Exports the unique identifier of the versioning configuration. |
| `README.md`    | This documentation file.                                       |

---

### **Inputs**

| **Name**                   | **Description**                                                                             | **Type**                                                              | **Default**                                                          | **Required** |
| -------------------------- | ------------------------------------------------------------------------------------------- | --------------------------------------------------------------------- | -------------------------------------------------------------------- | ------------ |
| `bucket`                   | The name of the S3 bucket.                                                                  | `string`                                                              | N/A                                                                  | Yes          |
| `expected_bucket_owner`    | The account ID of the expected bucket owner (for cross-account scenarios).                  | `string`                                                              | `null`                                                               | No           |
| `mfa`                      | Concatenation of MFA device ARN/serial, space, and code. Required if mfa_delete is enabled. | `string`                                                              | `null`                                                               | No           |
| `versioning_configuration` | Configuration block for versioning parameters.                                              | <pre>object({<br> status = string<br> mfa_delete = string<br>})</pre> | <pre>{<br> status = "Enabled"<br> mfa_delete = "Disabled"<br>}</pre> | No           |

#### Versioning Configuration

| **Parameter** | **Description**                                                                 | **Valid Values**                   |
| ------------- | ------------------------------------------------------------------------------- | ---------------------------------- |
| `status`      | Versioning state of the bucket.                                                 | `Enabled`, `Suspended`, `Disabled` |
| `mfa_delete`  | Specifies whether MFA delete is enabled in the bucket versioning configuration. | `Enabled`, `Disabled`              |

---

### **Outputs**

| **Name** | **Description**                                                                      |
| -------- | ------------------------------------------------------------------------------------ |
| `id`     | The bucket or bucket and expected_bucket_owner separated by a comma (,) if provided. |

---

### **Critical Configuration Notes**

#### MFA Delete Requirements

- **Root Account Only**: Only the **bucket owner (root account)** can enable MFA delete - IAM users cannot enable this feature even with administrator permissions
- **MFA Device Required**: You must have a **physical or virtual MFA device** configured and available to generate authentication codes
- **Console Limitation**: MFA delete **cannot be enabled using the AWS Management Console** - you must use Terraform, AWS CLI, or API

#### Versioning State Management

- **Irreversible Action**: Once you enable versioning on a bucket, it can **never return to an unversioned state**
- **Suspended State**: You can suspend versioning to stop accruing new versions while retaining existing versions
- **15-Minute Wait**: AWS recommends waiting **15 minutes after enabling versioning** before issuing write operations (PUT or DELETE) on objects

#### MFA Format Requirements

The `mfa` parameter must be a concatenation in one of these formats:

**Virtual MFA Device:**

```
"arn:aws:iam::account-id:mfa/device-name 123456"
```

**Physical MFA Device:**

```
"serial-number 123456"
```

Where `123456` is the current code displayed on your MFA device .

#### Terraform Version Compatibility

- **AWS Provider ≥4.0.0**: Use `aws_s3_bucket_versioning` resource as shown in this module
- **AWS Provider <4.0.0**: Use the deprecated `versioning` block within `aws_s3_bucket` resource

---

### **Examples**

#### Production Bucket with Maximum Protection

```hcl
module "s3_versioning_production" {
  source = "./modules/s3_bucket_versioning"

  bucket = "company-production-data"
  mfa    = "arn:aws:iam::123456789012:mfa/root-account-mfa-device 654321"

  versioning_configuration = {
    status     = "Enabled"
    mfa_delete = "Enabled"
  }
}
```

#### Compliance Data Bucket

```hcl
module "s3_versioning_compliance" {
  source = "./modules/s3_bucket_versioning"

  bucket                = "compliance-records"
  expected_bucket_owner = "123456789012"

  versioning_configuration = {
    status     = "Enabled"
    mfa_delete = "Enabled"
  }
}
```

#### Integration with S3 Bucket Module

```hcl
# Your existing S3 bucket module
module "s3_bucket" {
  source = "./modules/s3_bucket"
  bucket = "my-application-bucket"
}

# Versioning configuration
module "s3_versioning" {
  source = "./modules/s3_bucket_versioning"
  bucket = module.s3_bucket.id

  versioning_configuration = {
    status     = "Enabled"
    mfa_delete = "Disabled"
  }
}
```

---

### **Security Considerations**

- **MFA Delete Protection**: When enabled, MFA delete requires **two forms of authentication** to delete object versions or change versioning state, providing critical protection against accidental or malicious deletions
- **Bucket Ownership**: Only the root account that created the bucket can enable MFA delete - this cannot be delegated to IAM users
- **Lifecycle Configuration**: Note that **MFA delete cannot be used with S3 Lifecycle configurations** for automatic object expiration

---

### **Troubleshooting**

If you encounter issues with MFA delete not being reflected in your Terraform state, this may be due to a known issue in older AWS provider versions. Ensure you're using the latest AWS provider version and consider explicit state imports if needed .

---

### **Authors**

Maintained by [Your Name/Team].

---

### **License**

This project is licensed under the MIT License.
