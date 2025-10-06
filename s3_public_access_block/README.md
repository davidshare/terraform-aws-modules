### AWS Terraform Module: S3 Bucket Public Access Block

This Terraform module manages the **Public Access Block** settings for an Amazon S3 bucket. It allows you to control whether public access is blocked at the bucket level—critical for security compliance and preventing accidental public exposure of sensitive data.

Use this module alongside your S3 bucket and bucket policy modules to enforce secure-by-default configurations.

---

### **Usage**

#### Example Configuration

```hcl
module "s3_public_access_block" {
  source = "./s3_bucket_public_access_block"

  bucket = "my-secure-bucket"

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}
```

> 🔒 **Best Practice**: Set all four settings to `true` for maximum security (default in many compliance frameworks like CIS AWS Foundations).

---

### **Features**

- **Full Control**: Configure all four S3 Public Access Block settings independently.
- **Security-First**: Helps prevent accidental public exposure of S3 objects.
- **Composable**: Designed to be used with your existing S3 bucket module.
- **Compliance Ready**: Aligns with AWS security best practices and standards like CIS, HIPAA, and PCI-DSS.

---

### Requirements

| Name         | Version   |
| ------------ | --------- |
| Terraform    | >= 1.7.5  |
| AWS Provider | >= 5.77.0 |

> ✅ Fully compatible with **AWS Provider v6.15+** and **Terraform CLI v1.13.3**.

---

### Providers

| Provider | Source    | Version   |
| -------- | --------- | --------- |
| `aws`    | HashiCorp | >= 5.77.0 |

---

### **Explanation of Files**

| **File**       | **Description**                                                |
| -------------- | -------------------------------------------------------------- |
| `main.tf`      | Defines the `aws_s3_bucket_public_access_block` resource.      |
| `variables.tf` | Declares input variables for all public access block settings. |
| `outputs.tf`   | Exports the bucket name and applied settings for reference.    |

---

### **Inputs**

| **Name**                  | **Description**                                                                                | **Type** | **Default** | **Required** |
| ------------------------- | ---------------------------------------------------------------------------------------------- | -------- | ----------- | ------------ |
| `bucket`                  | The name of the S3 bucket to apply public access block settings to.                            | `string` | N/A         | Yes          |
| `block_public_acls`       | Whether to block new public ACLs and prevent existing public ACLs from granting public access. | `bool`   | `true`      | No           |
| `block_public_policy`     | Whether to block bucket policies that grant public access.                                     | `bool`   | `true`      | No           |
| `ignore_public_acls`      | Whether to ignore public ACLs on objects in this bucket.                                       | `bool`   | `true`      | No           |
| `restrict_public_buckets` | Whether to restrict public access to only AWS service principals and authorized users.         | `bool`   | `true`      | No           |

> 💡 **Default Behavior**: All settings default to `true` to enforce a secure baseline.

---

### **Outputs**

| **Name**                  | **Description**                                          |
| ------------------------- | -------------------------------------------------------- |
| `bucket`                  | The name of the bucket with public access block applied. |
| `block_public_acls`       | The effective `block_public_acls` setting.               |
| `block_public_policy`     | The effective `block_public_policy` setting.             |
| `ignore_public_acls`      | The effective `ignore_public_acls` setting.              |
| `restrict_public_buckets` | The effective `restrict_public_buckets` setting.         |

---

### **Example Usages**

#### Secure Bucket (Default – Recommended for Private Data)

```hcl
module "secure_bucket_access_block" {
  source = "./s3_bucket_public_access_block"

  bucket = module.s3_private_bucket.id
}
```

#### Static Website Bucket (Allows Public Read via Policy)

```hcl
module "website_bucket_access_block" {
  source = "./s3_bucket_public_access_block"

  bucket = module.s3_website.id

  # Allow public policy (required for static website hosting)
  block_public_policy     = false
  block_public_acls       = true
  ignore_public_acls      = true
  restrict_public_buckets = false
}
```

> ⚠️ **Warning**: Disabling `block_public_policy` and `restrict_public_buckets` is **required** for public static websites—but ensure your bucket policy is minimal (e.g., only `s3:GetObject`).

---

### **Integration with S3 Bucket Module**

Use all three modules together for full control:

```hcl
module "s3" {
  source = "./s3_bucket"
  bucket = "my-app-assets"
  tags   = { Environment = "prod" }
}

module "public_access_block" {
  source = "./s3_bucket_public_access_block"
  bucket = module.s3.id
  # Keep defaults (all true) for private bucket
}

# Only add if you need public access (e.g., static site)
# module "bucket_policy" {
#   source = "./s3_bucket_policy"
#   bucket = module.s3.id
#   policy = ...
# }
```

---

### **Authors**

Maintained by [David Essien](https://davidessien.com)

---

### **License**

This project is licensed under the MIT License.
