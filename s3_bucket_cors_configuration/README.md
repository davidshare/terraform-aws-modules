# AWS Terraform Module: S3 Bucket CORS Configuration

This Terraform module provisions an **AWS S3 Bucket CORS Configuration** resource, enabling Cross-Origin Resource Sharing (CORS) for S3 buckets. CORS allows web applications hosted in one domain to access resources in another domain.

---

### **Usage**

#### Basic CORS Configuration Example

```hcl
module "s3_bucket_cors" {
  source = "./modules/s3_bucket_cors"

  bucket = "my-website-bucket"

  cors_rules = [
    {
      allowed_headers = ["*"]
      allowed_methods = ["PUT", "POST", "DELETE"]
      allowed_origins = ["https://www.example.com"]
      expose_headers  = ["ETag", "x-amz-server-side-encryption"]
      max_age_seconds = 3000
    },
    {
      allowed_methods = ["GET"]
      allowed_origins = ["*"]
    }
  ]
}
```

#### Multiple Specific Origins Example

```hcl
module "s3_bucket_cors_multiple" {
  source = "./modules/s3_bucket_cors"

  bucket = "my-api-bucket"

  cors_rules = [
    {
      id              = "main-app"
      allowed_headers = ["Authorization", "Content-Type"]
      allowed_methods = ["GET", "POST", "PUT"]
      allowed_origins = ["https://app.example.com", "https://staging.example.com"]
      max_age_seconds = 3600
    },
    {
      id              = "mobile-app"
      allowed_methods = ["GET", "HEAD"]
      allowed_origins = ["https://mobile.example.com"]
    }
  ]
}
```

#### Cross-Account CORS Configuration Example

```hcl
module "s3_bucket_cors_cross_account" {
  source = "./modules/s3_bucket_cors"

  bucket                = "shared-resources-bucket"
  expected_bucket_owner = "123456789012"

  cors_rules = [
    {
      allowed_headers = ["*"]
      allowed_methods = ["GET", "PUT", "POST"]
      allowed_origins = ["https://partner.example.com", "https://client.example.com"]
      expose_headers  = ["x-amz-request-id", "x-amz-id-2"]
      max_age_seconds = 1800
    }
  ]
}
```

---

### **Features**

- Configures Cross-Origin Resource Sharing (CORS) for S3 buckets
- Supports multiple CORS rules (up to 100 rules)
- Handles cross-account bucket ownership scenarios
- Includes comprehensive input validation for HTTP methods and formats
- Supports wildcard origins and headers
- Configurable preflight request caching with max_age_seconds
- Unique rule identification with optional ID field

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

| **File**       | **Description**                                                            |
| -------------- | -------------------------------------------------------------------------- |
| `main.tf`      | Defines the AWS S3 bucket CORS configuration resource with dynamic blocks. |
| `variables.tf` | Specifies input variables with comprehensive validation rules.             |
| `outputs.tf`   | Exports the unique identifier of the CORS configuration.                   |

---

### **Inputs**

| **Name**                | **Description**                                                               | **Type**                                                                                                                                                                                                                                                        | **Default** | **Required** |
| ----------------------- | ----------------------------------------------------------------------------- | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ----------- | ------------ |
| `bucket`                | The name of the bucket to configure CORS for.                                 | `string`                                                                                                                                                                                                                                                        | N/A         | Yes          |
| `expected_bucket_owner` | The account ID of the expected bucket owner (for cross-account scenarios).    | `string`                                                                                                                                                                                                                                                        | `null`      | No           |
| `cors_rules`            | List of CORS rules to apply to the bucket. You can configure up to 100 rules. | <pre>list(object({<br> id = optional(string)<br> allowed_headers = optional(list(string))<br> allowed_methods = list(string)<br> allowed_origins = list(string)<br> expose_headers = optional(list(string))<br> max_age_seconds = optional(number)<br>}))</pre> | `[]`        | No           |

#### CORS Rule Configuration

| **Parameter**     | **Description**                                                          | **Required** |
| ----------------- | ------------------------------------------------------------------------ | ------------ |
| `id`              | Unique identifier for the rule (max 255 characters).                     | No           |
| `allowed_headers` | Set of headers specified in Access-Control-Request-Headers header.       | No           |
| `allowed_methods` | Set of HTTP methods allowed (GET, PUT, HEAD, POST, DELETE).              | Yes          |
| `allowed_origins` | Set of origins allowed to access the bucket.                             | Yes          |
| `expose_headers`  | Set of headers in response that applications can access from JavaScript. | No           |
| `max_age_seconds` | Time in seconds browser caches preflight response.                       | No           |

#### Valid HTTP Methods

- `GET`
- `PUT`
- `HEAD`
- `POST`
- `DELETE`

---

### **Outputs**

| **Name** | **Description**                                                                      |
| -------- | ------------------------------------------------------------------------------------ |
| `id`     | The bucket or bucket and expected_bucket_owner separated by a comma (,) if provided. |

---

### **Important Configuration Notes**

#### Single Configuration Limit

- **Critical**: S3 buckets only support a **single CORS configuration**. Declaring multiple `aws_s3_bucket_cors_configuration` resources for the same bucket will cause perpetual differences in your Terraform state.

#### Rule Limits

- Maximum of **100 CORS rules** per bucket configuration

#### Wildcard Usage

- **Origins**: You can use `*` as a wildcard in `allowed_origins` (e.g., `https://*.example.com`)
- **Headers**: The `*` wildcard in `allowed_headers` can be used to allow all headers
- Each wildcard string can contain at most one `*` character

#### Preflight Requests

- `max_age_seconds` controls how long browsers cache preflight (OPTIONS) request responses
- Longer values improve performance but delay policy changes taking effect

#### Cross-Origin Security

- Be specific with `allowed_origins` when possible instead of using `*`
- Consider using specific domains rather than wildcards for production environments

---

### **Examples**

#### API Bucket with Multiple Environments

```hcl
module "api_bucket_cors" {
  source = "./modules/s3_bucket_cors"

  bucket = "company-api-bucket"

  cors_rules = [
    {
      id              = "production"
      allowed_headers = ["Authorization", "Content-Type", "X-API-Key"]
      allowed_methods = ["GET", "POST", "PUT", "DELETE"]
      allowed_origins = ["https://app.company.com", "https://api.company.com"]
      expose_headers  = ["X-Request-Id", "X-Response-Time"]
      max_age_seconds = 3600
    },
    {
      id              = "development"
      allowed_methods = ["GET", "POST", "PUT", "DELETE"]
      allowed_origins = ["https://dev.company.com", "http://localhost:3000"]
      max_age_seconds = 600
    }
  ]
}
```

#### Public Read-Only Bucket

```hcl
module "public_bucket_cors" {
  source = "./modules/s3_bucket_cors"

  bucket = "public-assets-bucket"

  cors_rules = [
    {
      allowed_methods = ["GET", "HEAD"]
      allowed_origins = ["*"]
      max_age_seconds = 86400
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
  # ... other configurations
}

# CORS configuration
module "s3_bucket_cors" {
  source = "./modules/s3_bucket_cors"
  bucket = module.s3_bucket.id

  cors_rules = [
    {
      allowed_headers = ["*"]
      allowed_methods = ["GET", "PUT", "POST", "DELETE"]
      allowed_origins = ["https://my-app.example.com"]
      expose_headers  = ["ETag"]
      max_age_seconds = 3000
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
