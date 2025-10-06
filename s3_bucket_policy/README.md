### AWS Terraform Module: S3 Bucket Policy

This Terraform module is designed to attach a JSON-formatted bucket policy to an existing S3 bucket. It provides a clean, reusable, and composable way to manage access permissions for your S3 buckets—ideal for use with static websites, CloudFront distributions, cross-account access, or any scenario requiring fine-grained S3 permissions.

---

### **Usage**

#### Example Configuration

```hcl
module "s3_bucket_policy" {
  source = "./s3_bucket_policy"

  bucket = "my-static-website-bucket"
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid       = "PublicRead"
        Effect    = "Allow"
        Principal = "*"
        Action    = "s3:GetObject"
        Resource  = "arn:aws:s3:::my-static-website-bucket/*"
      }
    ]
  })
}
```

> 💡 **Tip**: Use `jsonencode()` to safely construct policies in HCL—this avoids syntax errors and ensures valid JSON.

---

### **Features**

- **Simple & Focused**: Only manages the bucket policy—no side effects.
- **Composable**: Designed to be used alongside your S3 bucket module.
- **Flexible Policy Input**: Accepts any valid S3 bucket policy as a JSON string.
- **Full Compatibility**: Works with all S3 use cases (public websites, private buckets, CloudFront origins, etc.).

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

| **File**       | **Description**                                                  |
| -------------- | ---------------------------------------------------------------- |
| `main.tf`      | Defines the `aws_s3_bucket_policy` resource.                     |
| `variables.tf` | Declares input variables: `bucket` and `policy`.                 |
| `outputs.tf`   | Exports the applied policy and resource ID for debugging or use. |

---

### **Inputs**

| **Name**   | **Description**                                      | **Type**   | **Default** | **Required** |
| ---------- | ---------------------------------------------------- | ---------- | ----------- | ------------ |
| `bucket`   | The name of the S3 bucket to attach the policy to.   | `string`   | N/A         | Yes          |
| `policy`   | A valid JSON-formatted S3 bucket policy as a string. | `string`   | N/A         | Yes          |

---

### **Outputs**

| **Name**   | **Description**                     |
| ---------- | ----------------------------------- |
| `id`       | The bucket name (ID of the policy). |
| `policy`   | The JSON policy that was applied.   |

---

### **Example Usages**

#### Public Read Policy for Static Website

```hcl
module "website_bucket_policy" {
  source = "./s3_bucket_policy"

  bucket = module.s3_website.id
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid       = "AllowPublicRead"
        Effect    = "Allow"
        Principal = "*"
        Action    = "s3:GetObject"
        Resource  = "${module.s3_website.arn}/*"
      }
    ]
  })
}
```

#### CloudFront Origin Access Identity (OAI) Policy

```hcl
module "cloudfront_bucket_policy" {
  source = "./s3_bucket_policy"

  bucket = aws_s3_bucket.assets.id
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid       = "CloudFrontAccess"
        Effect    = "Allow"
        Principal = {
          AWS = "arn:aws:iam::cloudfront:user/CloudFront Origin Access Identity ABC123XYZ"
        }
        Action    = "s3:GetObject"
        Resource  = "${aws_s3_bucket.assets.arn}/*"
      }
    ]
  })
}
```

---

### **Important Notes**

- This module **does not manage** the S3 bucket itself—only its policy.
- Ensure that **S3 Block Public Access** settings are configured appropriately (e.g., disabled for public websites) using the `aws_s3_bucket_public_access_block` resource if needed.
- Always validate your policy JSON using tools like the [AWS Policy Validator](https://awspolicygen.s3.amazonaws.com/policygen.html) or `terraform validate`.

---

### **Authors**

Maintained by [David Essien](https://davidessien.com)

---

### **License**

This project is licensed under the MIT License.