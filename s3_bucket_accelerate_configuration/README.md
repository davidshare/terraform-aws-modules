### AWS Terraform Module: S3 Bucket Transfer Acceleration

This Terraform module configures **Amazon S3 Transfer Acceleration** for an existing S3 bucket. Transfer Acceleration enables fast, secure file uploads to S3 by leveraging Amazon CloudFront’s globally distributed edge locations, significantly improving upload performance for clients far from the bucket’s region.

Use this module to enable or suspend transfer acceleration on any S3 bucket that meets AWS requirements (e.g., DNS-compliant bucket name, no period in name if using HTTPS).

---

### **Usage**

#### Enable Transfer Acceleration

```hcl
module "s3_accelerate" {
  source = "./s3_bucket_accelerate_configuration"

  bucket = "my-global-upload-bucket"
  status = "Enabled"
}
```

#### Suspend Transfer Acceleration

```hcl
module "s3_accelerate" {
  source = "./s3_bucket_accelerate_configuration"

  bucket = "my-global-upload-bucket"
  status = "Suspended"
}
```

#### With Expected Bucket Owner (for cross-account scenarios)

```hcl
module "s3_accelerate" {
  source = "./s3_bucket_accelerate_configuration"

  bucket                 = "shared-bucket"
  status                 = "Enabled"
  expected_bucket_owner  = "123456789012"
}
```

---

### **Features**

- **Enable or disable S3 Transfer Acceleration** with a single parameter.
- **Supports cross-account operations** via `expected_bucket_owner`.
- **Validates input** to ensure compliance with AWS requirements (e.g., status values, account ID format).
- **Lightweight and composable** — designed to be used alongside your core S3 bucket module.

---

### Requirements

| Name         | Version   |
| ------------ | --------- |
| Terraform    | >= 1.7.5  |
| AWS Provider | >= 5.77.0 |

> ✅ Fully compatible with **AWS Provider v6.15+**.

---

### Providers

| Provider | Source    | Version   |
| -------- | --------- | --------- |
| `aws`    | HashiCorp | >= 5.77.0 |

---

### **Explanation of Files**

| **File**       | **Description**                                                              |
| -------------- | ---------------------------------------------------------------------------- |
| `main.tf`      | Defines the `aws_s3_bucket_accelerate_configuration` resource.               |
| `variables.tf` | Declares input variables with validation for bucket name, status, and owner. |
| `outputs.tf`   | Exports the bucket name and current acceleration status for reference.       |

---

### **Inputs**

| **Name**                | **Description**                                                         | **Type** | **Default** | **Required** |
| ----------------------- | ----------------------------------------------------------------------- | -------- | ----------- | ------------ |
| `bucket`                | Name of the S3 bucket to configure transfer acceleration for.           | `string` | N/A         | Yes          |
| `status`                | Transfer acceleration state. Valid values: `Enabled` or `Suspended`.    | `string` | N/A         | Yes          |
| `expected_bucket_owner` | AWS account ID of the expected bucket owner (for cross-account safety). | `string` | `null`      | No           |

> 🔒 **Validation**:
>
> - `status` must be `Enabled` or `Suspended`.
> - `expected_bucket_owner` must be a 12-digit AWS account ID if provided.

---

### **Outputs**

| **Name** | **Description**                                                   |
| -------- | ----------------------------------------------------------------- |
| `id`     | The name of the S3 bucket.                                        |
| `status` | The current transfer acceleration status (`Enabled`/`Suspended`). |

---

### **Important Notes**

- **Bucket naming**: Transfer Acceleration requires a **globally unique, DNS-compliant bucket name** (lowercase, no periods if using HTTPS).
- **Endpoint**: Once enabled, use the **accelerate endpoint**:  
  `https://<bucket>.s3-accelerate.amazonaws.com`
- **Cost**: Transfer Acceleration incurs **additional data transfer fees**. Review [AWS pricing](https://aws.amazon.com/s3/pricing/) before enabling.
- **Region support**: Not available in all AWS regions (e.g., not supported in `us-gov-west-1` or `cn-north-1`).

---

### **Authors**

Maintained by [David Essien](https://davidessien.com)

---

### **License**

This project is licensed under the MIT License.
