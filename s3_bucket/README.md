### AWS Terraform Module: S3 Bucket

This Terraform module is designed to manage S3 buckets with a variety of configurations, including versioning, lifecycle policies, CORS rules, server-side encryption, and logging.

---

### **Usage**

#### Example Configuration

```hcl
module "s3_bucket" {
  source = "./s3_bucket"

  bucket        = "my-awesome-bucket"
  force_destroy = true
  versioning = {
    enabled    = true
    mfa_delete = false
  }
  lifecycle_rule = [
    {
      id    = "log-retention"
      prefix = "logs/"
      enabled = true
      expiration = [
        { days = 30 }
      ]
    }
  ]
  server_side_encryption_configuration = {
    sse_algorithm     = "aws:kms"
    kms_master_key_id = "arn:aws:kms:region:account-id:key/key-id"
  }
  tags = {
    Environment = "production"
    Team        = "DevOps"
  }
}
```

---

### **Features**

- **Versioning:** Support for enabling and managing versioning and MFA delete.
- **Lifecycle Rules:** Granular lifecycle management for object transitions, expiration, and abort rules.
- **CORS Rules:** Configuration of Cross-Origin Resource Sharing.
- **Static Website Hosting:** Configure static website hosting for the bucket.
- **Logging:** Enable logging to a target bucket with a specific prefix.
- **Server-Side Encryption:** Set up default encryption with optional KMS integration.
- **Force Destroy:** Delete all objects in the bucket on resource destruction.

---

### **Requirements**

| **Dependency** | **Version** |
| -------------- | ----------- |
| Terraform      | >= 1.3.0    |
| AWS Provider   | >= 4.0      |

---

### **Providers**

| **Name** | **Source**    |
| -------- | ------------- |
| `aws`    | hashicorp/aws |

---

### **Explanation of Files**

| **File**       | **Description**                                                                  |
| -------------- | -------------------------------------------------------------------------------- |
| `main.tf`      | Contains the S3 bucket resource and its dynamic configurations.                  |
| `variables.tf` | Defines all input variables for customizing the S3 bucket.                       |
| `outputs.tf`   | Exports the bucket ID, ARN, and domain names for use in other Terraform modules. |

---

### **Inputs**

| **Name**                               | **Description**                                             | **Type**      | **Default** | **Required** |
| -------------------------------------- | ----------------------------------------------------------- | ------------- | ----------- | ------------ |
| `bucket`                               | The name of the bucket.                                     | `string`      | N/A         | Yes          |
| `force_destroy`                        | Whether to delete all objects in the bucket on destruction. | `bool`        | `false`     | No           |
| `versioning`                           | Map containing versioning configuration.                    | `map(string)` | `{}`        | No           |
| `website`                              | Map containing static website hosting configuration.        | `map(string)` | `{}`        | No           |
| `cors_rule`                            | List of CORS rules.                                         | `any`         | `[]`        | No           |
| `lifecycle_rule`                       | List of lifecycle management rules.                         | `any`         | `[]`        | No           |
| `logging`                              | Map containing logging configuration.                       | `map(string)` | `{}`        | No           |
| `server_side_encryption_configuration` | Map containing server-side encryption configuration.        | `any`         | `{}`        | No           |
| `tags`                                 | A map of tags to assign to the bucket.                      | `map(string)` | `{}`        | No           |

---

### **Outputs**

| **Name**                         | **Description**                                |
| -------------------------------- | ---------------------------------------------- |
| `id`                   | The ID (name) of the bucket.                   |
| `arn`                  | The ARN of the bucket.                         |
| `domain_name`          | The domain name of the bucket.                 |
| `regional_domain_name` | The region-specific domain name of the bucket. |

---

### **Example Usages**

#### Basic Bucket with Tags

```hcl
module "basic_bucket" {
  source = "./s3_bucket"

  bucket = "simple-bucket"
  tags = {
    Owner = "John Doe"
    Project = "Test"
  }
}
```

#### Bucket with Lifecycle and Encryption

```hcl
module "advanced_bucket" {
  source = "./s3_bucket"

  bucket        = "secure-lifecycle-bucket"
  force_destroy = true
  lifecycle_rule = [
    {
      id    = "transition-rule"
      prefix = "archive/"
      enabled = true
      transition = [
        { days = 30, storage_class = "GLACIER" }
      ]
    }
  ]
  server_side_encryption_configuration = {
    sse_algorithm = "AES256"
  }
}
```

---

### **Authors**

Maintained by [David Essien](https://davidessien.com)

---

### **License**

This project is licensed under the MIT License.
