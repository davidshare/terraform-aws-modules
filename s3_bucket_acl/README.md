# AWS Terraform Module: S3 Bucket ACL

This Terraform module provisions an **AWS S3 Bucket ACL** resource, providing fine-grained access control for S3 buckets through either canned ACLs or custom access control policies with grants.

---

### **Usage**

#### Basic Example with Canned ACL

```hcl
module "s3_bucket_acl" {
  source = "./modules/s3_bucket_acl"

  bucket = "my-private-bucket"
  acl    = "private"
}
```

#### Public Read ACL

```hcl
module "s3_bucket_acl_public" {
  source = "./modules/s3_bucket_acl"

  bucket = "my-public-bucket"
  acl    = "public-read"
}
```

#### Custom Access Control Policy with Grants

```hcl
module "s3_bucket_acl_custom" {
  source = "./modules/s3_bucket_acl"

  bucket = "my-custom-acl-bucket"

  access_control_policy = {
    grants = [
      {
        permission = "READ"
        grantee = {
          type = "Group"
          uri  = "http://acs.amazonaws.com/groups/s3/LogDelivery"
        }
      },
      {
        permission = "FULL_CONTROL"
        grantee = {
          type = "CanonicalUser"
          id   = "abc123def456ghi789"
        }
      }
    ]
    owner = {
      id           = "abc123def456ghi789"
      display_name = "bucket-owner"
    }
  }
}
```

#### Cross-Account Bucket ACL

```hcl
module "s3_bucket_acl_cross_account" {
  source = "./modules/s3_bucket_acl"

  bucket                = "cross-account-bucket"
  acl                   = "bucket-owner-full-control"
  expected_bucket_owner = "123456789012"
}
```

---

### **Features**

- Supports both canned ACLs and custom access control policies
- Configures fine-grained permissions through grants system
- Handles cross-account bucket ownership scenarios
- Automatically manages conflicts between `acl` and `access_control_policy` parameters
- Includes comprehensive input validation
- Designed as a standalone module for maximum composability

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

| **File**       | **Description**                                                        |
| -------------- | ---------------------------------------------------------------------- |
| `main.tf`      | Defines the AWS S3 bucket ACL resource with dynamic blocks for grants. |
| `variables.tf` | Specifies input variables with comprehensive validation rules.         |
| `outputs.tf`   | Exports the unique identifier of the ACL configuration.                |

---

### **Inputs**

| **Name**                | **Description**                                                                    | **Type**                                                                                                                                                                                                                                                                                                       | **Default** | **Required** |
| ----------------------- | ---------------------------------------------------------------------------------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ----------- | ------------ |
| `bucket`                | The name of the bucket to apply the ACL to.                                        | `string`                                                                                                                                                                                                                                                                                                       | N/A         | Yes          |
| `acl`                   | The canned ACL to apply to the bucket. Conflicts with `access_control_policy`.     | `string`                                                                                                                                                                                                                                                                                                       | `null`      | No           |
| `access_control_policy` | Configuration block for custom ACL permissions using grants. Conflicts with `acl`. | <pre>object({<br> grants = list(object({<br> permission = string<br> grantee = object({<br> type = string<br> email_address = optional(string)<br> id = optional(string)<br> uri = optional(string)<br> })<br> }))<br> owner = object({<br> id = string<br> display_name = optional(string)<br> })<br>})</pre> | `null`      | No           |
| `expected_bucket_owner` | The account ID of the expected bucket owner (for cross-account scenarios).         | `string`                                                                                                                                                                                                                                                                                                       | `null`      | No           |

#### ACL Valid Values

- `private`
- `public-read`
- `public-read-write`
- `aws-exec-read`
- `authenticated-read`
- `bucket-owner-read`
- `bucket-owner-full-control`
- `log-delivery-write`

#### Grant Permission Valid Values

- `FULL_CONTROL`
- `WRITE`
- `WRITE_ACP`
- `READ`
- `READ_ACP`

#### Grantee Type Valid Values

- `CanonicalUser`
- `AmazonCustomerByEmail`
- `Group`

---

### **Outputs**

| **Name** | **Description**                                                 |
| -------- | --------------------------------------------------------------- |
| `id`     | The bucket, expected_bucket_owner, and acl separated by commas. |

---

### **Important Configuration Notes**

#### Mutually Exclusive Parameters

- **`acl`** and **`access_control_policy`** are mutually exclusive
- The module will use whichever parameter is provided
- If both are provided, `access_control_policy` takes precedence

#### Grantee Configuration Requirements

- **`CanonicalUser`**: Requires `id` parameter
- **`AmazonCustomerByEmail`**: Requires `email_address` parameter
- **`Group`**: Requires `uri` parameter (e.g., `http://acs.amazonaws.com/groups/s3/LogDelivery`)

#### Required Grantee URIs for Groups

- **Log Delivery Group**: `http://acs.amazonaws.com/groups/s3/LogDelivery`
- **All Users Group**: `http://acs.amazonaws.com/groups/global/AllUsers`
- **Authenticated Users Group**: `http://acs.amazonaws.com/groups/global/AuthenticatedUsers`

#### Integration with Other S3 Modules

This module is designed to work alongside other S3 modules:

```hcl
# S3 Bucket Module
module "s3_bucket" {
  source = "./modules/s3_bucket"
  bucket = "my-bucket"
}

# S3 Ownership Controls Module
module "ownership_controls" {
  source = "./modules/s3_ownership_controls"
  bucket = module.s3_bucket.id
}

# S3 Public Access Block Module
module "public_access_block" {
  source = "./modules/s3_public_access_block"
  bucket = module.s3_bucket.id
}

# S3 Bucket ACL Module
module "bucket_acl" {
  source = "./modules/s3_bucket_acl"
  bucket = module.s3_bucket.id
  acl    = "private"

  depends_on = [
    module.ownership_controls,
    module.public_access_block
  ]
}
```

#### Security Considerations

- Use public ACLs (`public-read`, `public-read-write`) with caution as they expose bucket contents
- Consider using `bucket-owner-full-control` for cross-account scenarios
- Always configure appropriate public access blocks when using public ACLs

---

### **Examples**

#### Log Delivery Bucket with Custom Grants

```hcl
module "log_bucket_acl" {
  source = "./modules/s3_bucket_acl"

  bucket = "my-log-bucket"

  access_control_policy = {
    grants = [
      {
        permission = "WRITE"
        grantee = {
          type = "Group"
          uri  = "http://acs.amazonaws.com/groups/s3/LogDelivery"
        }
      },
      {
        permission = "READ_ACP"
        grantee = {
          type = "Group"
          uri  = "http://acs.amazonaws.com/groups/s3/LogDelivery"
        }
      }
    ]
    owner = {
      id = data.aws_canonical_user_id.current.id
    }
  }
}
```

#### Authenticated Users Read Access

```hcl
module "authenticated_read_acl" {
  source = "./modules/s3_bucket_acl"

  bucket = "shared-data-bucket"

  access_control_policy = {
    grants = [
      {
        permission = "READ"
        grantee = {
          type = "Group"
          uri  = "http://acs.amazonaws.com/groups/global/AuthenticatedUsers"
        }
      }
    ]
    owner = {
      id = data.aws_canonical_user_id.current.id
    }
  }
}
```

---

### **Authors**

Maintained by [Your Name/Team].

---

### **License**

This project is licensed under the MIT License.
