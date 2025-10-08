# AWS Terraform Module: S3 Bucket Website Configuration

This Terraform module provisions an **AWS S3 Bucket Website Configuration** resource, enabling static website hosting, redirects, and advanced routing rules for S3 buckets.

---

### **Usage**

#### Basic Website Hosting Example

```hcl
module "s3_website" {
  source = "./modules/s3_website"

  bucket = "my-static-website-bucket"

  index_document = {
    suffix = "index.html"
  }

  error_document = {
    key = "error.html"
  }
}
```

#### Advanced Example with Routing Rules

```hcl
module "s3_website_advanced" {
  source = "./modules/s3_website"

  bucket = "my-advanced-website"

  index_document = {
    suffix = "home.html"
  }

  routing_rule = [
    {
      condition = {
        key_prefix_equals = "docs/"
      }
      redirect = {
        replace_key_prefix_with = "documents/"
        http_redirect_code      = "301"
      }
    },
    {
      condition = {
        http_error_code_returned_equals = "404"
      }
      redirect = {
        host_name          = "backup.example.com"
        protocol           = "https"
        http_redirect_code = "302"
      }
    }
  ]
}
```

#### Redirect All Requests Example

```hcl
module "s3_redirect" {
  source = "./modules/s3_website"

  bucket = "redirect-bucket"

  redirect_all_requests_to = {
    host_name = "www.example.com"
    protocol  = "https"
  }
}
```

#### Using JSON Routing Rules

```hcl
module "s3_website_json" {
  source = "./modules/s3_website"

  bucket = "json-rules-website"

  index_document = {
    suffix = "index.html"
  }

  routing_rules = <<EOF
[{
    "Condition": {
        "KeyPrefixEquals": "images/"
    },
    "Redirect": {
        "ReplaceKeyPrefixWith": "assets/",
        "HttpRedirectCode": "301"
    }
}]
EOF
}
```

---

### **Features**

- Configures static website hosting for S3 buckets
- Supports custom index and error documents
- Implements advanced routing rules with conditions and redirects
- Provides both individual routing rules and JSON-based routing rules
- Supports cross-account bucket ownership validation
- Handles complete redirect configurations for entire buckets
- Exports website endpoints and domains for DNS configuration

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

| **File**       | **Description**                                                                 |
| -------------- | ------------------------------------------------------------------------------- |
| `main.tf`      | Defines the AWS S3 bucket website configuration resource with dynamic blocks.   |
| `variables.tf` | Specifies input variables for customizing the website configuration.            |
| `outputs.tf`   | Exports key attributes of the website configuration for use in other resources. |

---

### **Inputs**

| **Name**                   | **Description**                                                                       | **Type**                                                                                                                                                                                                                                                                                                                                                                                                   | **Default** | **Required** |
| -------------------------- | ------------------------------------------------------------------------------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ----------- | ------------ |
| `bucket`                   | Name of the bucket to configure for website hosting.                                  | `string`                                                                                                                                                                                                                                                                                                                                                                                                   | N/A         | Yes          |
| `expected_bucket_owner`    | Account ID of the expected bucket owner (for cross-account scenarios).                | `string`                                                                                                                                                                                                                                                                                                                                                                                                   | `null`      | No           |
| `index_document`           | Configuration for the index document. Required unless using redirect_all_requests_to. | <pre>object({<br> suffix = string<br>})</pre>                                                                                                                                                                                                                                                                                                                                                              | `null`      | No           |
| `error_document`           | Configuration for the error document. Conflicts with redirect_all_requests_to.        | <pre>object({<br> key = string<br>})</pre>                                                                                                                                                                                                                                                                                                                                                                 | `null`      | No           |
| `redirect_all_requests_to` | Configuration for redirecting all requests to another host.                           | <pre>object({<br> host_name = string<br> protocol = optional(string)<br>})</pre>                                                                                                                                                                                                                                                                                                                           | `null`      | No           |
| `routing_rule`             | List of individual routing rules. Conflicts with routing_rules.                       | <pre>list(object({<br> condition = optional(object({<br> http_error_code_returned_equals = optional(string)<br> key_prefix_equals = optional(string)<br> }))<br> redirect = object({<br> host_name = optional(string)<br> http_redirect_code = optional(string)<br> protocol = optional(string)<br> replace_key_prefix_with = optional(string)<br> replace_key_with = optional(string)<br> })<br>}))</pre> | `[]`        | No           |
| `routing_rules`            | JSON string containing routing rules. Conflicts with routing_rule.                    | `string`                                                                                                                                                                                                                                                                                                                                                                                                   | `null`      | No           |

---

### **Outputs**

| **Name**           | **Description**                                                                    |
| ------------------ | ---------------------------------------------------------------------------------- |
| `id`               | The bucket or bucket and expected_bucket_owner separated by a comma (if provided). |
| `website_domain`   | Domain of the website endpoint (used for Route 53 alias records).                  |
| `website_endpoint` | Website endpoint URL for the S3 bucket.                                            |

---

### **Important Configuration Notes**

#### Mutually Exclusive Parameters

- **`redirect_all_requests_to`** conflicts with:

  - `error_document`
  - `index_document`
  - `routing_rule`
  - `routing_rules`

- **`routing_rule`** conflicts with:
  - `routing_rules`

#### Required Combinations

You must specify one of these configurations:

- **Website Hosting**: `index_document` (and optionally `error_document`, `routing_rule`, or `routing_rules`)
- **Complete Redirect**: `redirect_all_requests_to` alone

#### Routing Rule Conditions

- At least one condition must be specified in each routing rule:
  - `key_prefix_equals`: Redirects requests for objects with specific key prefixes
  - `http_error_code_returned_equals`: Redirects based on HTTP error codes

#### Redirect Options

- `replace_key_prefix_with`: Replaces the key prefix (use with `key_prefix_equals`)
- `replace_key_with`: Replaces the entire object key
- `host_name`: Redirects to a different host
- `protocol`: Specifies HTTP or HTTPS for redirects
- `http_redirect_code`: Sets the HTTP redirect status code (301, 302, etc.)

---

### **Examples**

#### Simple Static Website with Custom Error Page

```hcl
module "static_portfolio" {
  source = "./modules/s3_website"

  bucket = "my-portfolio-site"

  index_document = {
    suffix = "index.html"
  }

  error_document = {
    key = "404.html"
  }
}
```

#### Multi-language Site with Routing Rules

```hcl
module "multi_lang_site" {
  source = "./modules/s3_website"

  bucket = "company-website"

  index_document = {
    suffix = "en/index.html"
  }

  routing_rule = [
    {
      condition = {
        key_prefix_equals = "es/"
      }
      redirect = {
        replace_key_prefix_with = "spanish/"
      }
    },
    {
      condition = {
        key_prefix_equals = "fr/"
      }
      redirect = {
        replace_key_prefix_with = "french/"
      }
    }
  ]
}
```

#### Temporary Maintenance Redirect

```hcl
module "maintenance_redirect" {
  source = "./modules/s3_website"

  bucket = "maintenance-site"

  redirect_all_requests_to = {
    host_name = "status.example.com"
    protocol  = "https"
  }
}
```

---

### **Authors**

Maintained by [Your Name/Team].

---

### **License**

This project is licensed under the MIT License.
