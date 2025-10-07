# AWS CloudFront Distribution Terraform Module

This Terraform module simplifies the deployment and management of AWS CloudFront distributions. It allows the creation and configuration of CloudFront distributions, including cache behaviors, origins, SSL certificates, and more, based on user-defined inputs.

The purpose of this module is to enable seamless deployment of AWS CloudFront distributions with customizable configurations. It handles various CloudFront settings such as default cache behaviors, ordered cache behaviors, SSL configurations, custom error responses, and tags.

---

## Usage

### Code Example

```hcl
module "cloudfront_distribution" {
  source = "./cloudfront_distribution"

  enabled               = true
  is_ipv6_enabled       = true
  comment               = "My CloudFront Distribution"
  aliases               = ["example.com", "www.example.com"]
  price_class           = "PriceClass_100"
  origin                = [
    {
      domain_name = "example.com"
      origin_id   = "example-origin"
    }
  ]
  default_cache_behavior = {
    allowed_methods      = ["GET", "HEAD"]
    cached_methods       = ["GET"]
    target_origin_id     = "example-origin"
    forwarded_values     = { query_string = true, cookies = { forward = "all" } }
    viewer_protocol_policy = "redirect-to-https"
  }
}
```

### Explanation of Key Parameters

- **enabled**: A boolean that specifies whether the CloudFront distribution should be enabled to accept end-user requests.
- **is_ipv6_enabled**: A boolean that enables or disables IPv6 support for the distribution.
- **comment**: A comment to describe the distribution.
- **aliases**: A list of CNAMEs (alternate domain names) associated with the distribution.
- **price_class**: The price class for the distribution, which defines the global distribution range (e.g., `PriceClass_100`).
- **origin**: A list of origins for the distribution, where each origin can be a custom or S3 origin.
- **default_cache_behavior**: Configuration for the default cache behavior, including methods, cookies, query string handling, and viewer protocol policies.

---

### Requirements

| Name         | Version   |
| ------------ | --------- |
| Terraform    | >= 1.7.5  |
| AWS Provider | >= 5.77.0 |

---

### Providers

| Provider | Source    | Version   |
| -------- | --------- | --------- |
| `aws`    | HashiCorp | >= 5.77.0 |

---

## Features

- **Dynamic Origins**: Supports multiple origin types including custom and S3 origins.
- **Cache Behaviors**: Configurable default and ordered cache behaviors.
- **Custom Error Responses**: Ability to define custom error response configurations.
- **SSL Configuration**: Option to configure SSL certificates for the distribution.
- **Geo-restrictions**: Allows setting geographic restrictions for content delivery.
- **Flexible Tagging**: Supports tags for resource management.

---

## Explanation of Files

| File           | Description                                                                                     |
| -------------- | ----------------------------------------------------------------------------------------------- |
| `main.tf`      | The main resource configuration file that defines the CloudFront distribution and its settings. |
| `variables.tf` | Contains the variable definitions, including their types, descriptions, and default values.     |
| `outputs.tf`   | Defines the output values such as distribution ID, ARN, and domain name.                        |
| `README.md`    | Documentation for using and configuring the module.                                             |

---

## Inputs

| Variable                 | Description                                                      | Type   | Default          | Required |
| ------------------------ | ---------------------------------------------------------------- | ------ | ---------------- | -------- |
| `enabled`                | Whether the distribution is enabled to accept end-user requests. | bool   | true             | no       |
| `is_ipv6_enabled`        | Whether IPv6 is enabled for the distribution.                    | bool   | true             | no       |
| `comment`                | Any comment you want to add about the distribution.              | string | null             | no       |
| `default_root_object`    | The root object returned when an end user requests the root URL. | string | null             | no       |
| `aliases`                | Extra CNAMEs (alternate domain names) for the distribution.      | list   | []               | no       |
| `price_class`            | The price class for the distribution.                            | string | `PriceClass_100` | no       |
| `origin`                 | One or more origins for the distribution.                        | any    | -                | yes      |
| `default_cache_behavior` | The default cache behavior configuration.                        | any    | -                | yes      |
| `ordered_cache_behavior` | A list of ordered cache behaviors.                               | any    | []               | no       |
| `custom_error_response`  | Custom error response configurations.                            | any    | []               | no       |
| `restrictions`           | The restriction configuration for the distribution.              | any    | {}               | no       |
| `viewer_certificate`     | The SSL configuration for the distribution.                      | any    | -                | yes      |
| `web_acl_id`             | The ID of the AWS WAF Web ACL associated with the distribution.  | string | null             | no       |
| `tags`                   | A mapping of tags to assign to the resource.                     | map    | {}               | no       |

---

## Outputs

| Output                                | Description                                        |
| ------------------------------------- | -------------------------------------------------- |
| `cloudfront_distribution_id`          | The identifier for the CloudFront distribution.    |
| `cloudfront_distribution_arn`         | The ARN for the CloudFront distribution.           |
| `cloudfront_distribution_domain_name` | The domain name corresponding to the distribution. |

---

## Example Usage

### Basic Example

```hcl
module "cloudfront_distribution" {
  source = "./cloudfront_distribution"

  origin = [{
    domain_name = "mywebsite.com"
    origin_id   = "mywebsite-origin"
  }]
  default_cache_behavior = {
    allowed_methods      = ["GET", "HEAD"]
    cached_methods       = ["GET"]
    target_origin_id     = "mywebsite-origin"
    forwarded_values     = { query_string = true }
    viewer_protocol_policy = "redirect-to-https"
  }
}
```

### Advanced Example

```hcl
module "cloudfront_distribution" {
  source = "./cloudfront_distribution"

  aliases               = ["www.example.com", "example.com"]
  price_class           = "PriceClass_200"
  origin                = [
    {
      domain_name = "example.com"
      origin_id   = "example-origin"
    }
  ]
  default_cache_behavior = {
    allowed_methods      = ["GET", "HEAD"]
    cached_methods       = ["GET"]
    target_origin_id     = "example-origin"
    forwarded_values     = { query_string = true }
    viewer_protocol_policy = "allow-all"
  }
}
```

---

## Authors

This module is maintained by [David Essien](https://davidessien.com).

---

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for more details.
