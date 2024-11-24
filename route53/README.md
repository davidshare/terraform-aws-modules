### AWS Terraform Module: Route53 Hosted Zone and Records

This Terraform module simplifies the creation and management of Route53 hosted zones and DNS records.

---

### **Usage**

#### Example Configuration

```hcl
module "route53" {
  source = "./route53"

  zone_name      = "example.com"
  comment        = "Hosted zone for example.com"
  force_destroy  = true
  tags           = { Environment = "production" }
  records = [
    {
      name    = "www"
      type    = "A"
      ttl     = 300
      records = ["192.0.2.1"]
    },
    {
      name    = "api"
      type    = "CNAME"
      ttl     = 300
      records = ["api.example.com"]
    }
  ]
}
```

---

### **Features**

- Creates public or private hosted zones.
- Supports optional VPC association for private hosted zones.
- Automatically manages DNS records in the hosted zone.
- Supports `force_destroy` to remove all records upon zone deletion.

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

### **Explanation of Files**

| **File**       | **Description**                                                  |
| -------------- | ---------------------------------------------------------------- |
| `main.tf`      | Defines the hosted zone and records resources.                   |
| `variables.tf` | Contains input variables for zone configuration and DNS records. |
| `outputs.tf`   | Provides outputs such as the zone ID and name servers.           |

---

### **Inputs**

| **Name**        | **Description**                                                 | **Type**       | **Default** | **Required** |
| --------------- | --------------------------------------------------------------- | -------------- | ----------- | ------------ |
| `zone_name`     | The name of the hosted zone (e.g., `example.com`).              | `string`       | N/A         | Yes          |
| `comment`       | A comment for the hosted zone.                                  | `string`       | `null`      | No           |
| `vpc_id`        | VPC ID to associate with a private hosted zone (if applicable). | `string`       | `null`      | No           |
| `force_destroy` | Whether to destroy all records in the zone when destroying it.  | `bool`         | `false`     | No           |
| `records`       | List of DNS records (name, type, TTL, values).                  | `list(object)` | `[]`        | No           |
| `tags`          | A map of tags to add to all resources.                          | `map(string)`  | `{}`        | No           |

---

### **Outputs**

| **Name**       | **Description**                                       |
| -------------- | ----------------------------------------------------- |
| `zone_id`      | The ID of the created hosted zone.                    |
| `name_servers` | List of name servers associated with the hosted zone. |

---

### **Example Usages**

#### Public Hosted Zone with A and CNAME Records

```hcl
module "public_zone" {
  source = "./route53"

  zone_name     = "example.com"
  force_destroy = true
  records = [
    {
      name    = "www"
      type    = "A"
      ttl     = 300
      records = ["192.0.2.1"]
    },
    {
      name    = "blog"
      type    = "CNAME"
      ttl     = 300
      records = ["blog.example.com"]
    }
  ]
}
```

#### Private Hosted Zone with VPC Association

```hcl
module "private_zone" {
  source = "./route53"

  zone_name     = "internal.example.com"
  vpc_id        = "vpc-12345678"
  force_destroy = true
  tags = {
    Environment = "dev"
  }
  records = [
    {
      name    = "app"
      type    = "A"
      ttl     = 300
      records = ["10.0.0.10"]
    }
  ]
}
```

---

### **Features Supported for DNS Records**

- **Record Types**: A, AAAA, CNAME, TXT, SRV, PTR, MX, etc.
- **TTL**: Adjustable Time-to-Live for DNS records.
- **Multi-record Support**: Allows multiple values for a single record.

---

### **Authors**

Maintained by [David Essien](https://davidessien.com)

---

### **License**

This project is licensed under the MIT License.
