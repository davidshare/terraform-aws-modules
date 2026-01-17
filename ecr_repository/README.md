### AWS Terraform Module: ECR Repository

This Terraform module provisions an **AWS Elastic Container Registry (ECR) repository** with configurable settings for image scanning, tag mutability, encryption, and tagging. It supports multiple advanced features including exclusion filters for tag mutability.

---

### **Usage**

#### Basic Example

```hcl
module "ecr_repo" {
  source = "./ecr_repository"

  name  = "my-repo"
  tags  = { Environment = "stage" }

  image_scanning_configuration = {
    scan_on_push = true
  }

  encryption_configuration = {
    encryption_type = "AES256"
  }
}
```

#### Advanced Example (Immutable Tags with Exclusions & KMS Encryption)

```hcl
module "ecr_repo_advanced" {
  source = "./ecr_repository"

  name                 = "my-advanced-repo"
  image_tag_mutability = "IMMUTABLE_WITH_EXCLUSION"

  image_tag_mutability_exclusion_filters = [
    { filter = "latest*", filter_type = "WILDCARD" },
    { filter = "dev-*",  filter_type = "WILDCARD" }
  ]

  image_scanning_configuration = {
    scan_on_push = true
  }

  encryption_configuration = {
    encryption_type = "KMS"
    kms_key         = "arn:aws:kms:us-east-1:123456789012:key/abcd-efgh-ijkl-mnop"
  }

  tags = {
    Environment = "prod"
  }
}
```

---

### **Features**

- Configurable **tag mutability** (`MUTABLE`, `IMMUTABLE`, `IMMUTABLE_WITH_EXCLUSION`, `MUTABLE_WITH_EXCLUSION`).
- Supports **image scanning** on push.
- Optional **KMS or AES256 encryption**.
- Full support for **tagging** of ECR repositories.
- Supports **multiple tag exclusion filters** for advanced tag mutability control.

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

| **File**       | **Description**                                                                |
| -------------- | ------------------------------------------------------------------------------ |
| `main.tf`      | Defines the core ECR repository resource.                                      |
| `variables.tf` | Specifies input variables for customizing the repository configuration.        |
| `outputs.tf`   | Exports key attributes of the repository for use in other Terraform resources. |
| `README.md`    | Documentation and usage examples for the module.                               |

---

### **Inputs**

| **Name**                                 | **Description**                              | **Type**       | **Default**                                      | **Required** |
| ---------------------------------------- | -------------------------------------------- | -------------- | ------------------------------------------------ | ------------ |
| `name`                                   | Name of the repository                       | `string`       | N/A                                              | Yes          |
| `region`                                 | AWS region to create the repository          | `string`       | `null`                                           | No           |
| `tags`                                   | Tags to assign to the repository             | `map(string)`  | `{}`                                             | No           |
| `force_delete`                           | Delete repository even if it contains images | `bool`         | `false`                                          | No           |
| `image_tag_mutability`                   | Tag mutability setting                       | `string`       | `"MUTABLE"`                                      | No           |
| `image_tag_mutability_exclusion_filters` | List of exclusion filters for tag mutability | `list(object)` | `[]`                                             | No           |
| `image_scanning_configuration`           | Configuration for image scanning             | `object`       | `{ scan_on_push = false }`                       | No           |
| `encryption_configuration`               | Encryption settings for the repository       | `object`       | `{ encryption_type = "AES256", kms_key = null }` | No           |

---

### **Outputs**

| **Name**         | **Description**                             |
| ---------------- | ------------------------------------------- |
| `arn`            | The ARN of the repository                   |
| `repository_url` | The URL of the repository                   |
| `registry_id`    | Registry ID where the repository is created |
| `tags_all`       | All tags assigned to the repository         |

---

### **Examples**

#### Create a simple ECR repository

```hcl
module "ecr_simple" {
  source = "./ecr_repository"
  name   = "simple-repo"
}
```

#### Create an ECR repository with KMS encryption and scan-on-push

```hcl
module "ecr_secure" {
  source = "./ecr_repository"

  name = "secure-repo"

  encryption_configuration = {
    encryption_type = "KMS"
    kms_key         = "arn:aws:kms:us-east-1:123456789012:key/abcd-efgh-ijkl-mnop"
  }

  image_scanning_configuration = {
    scan_on_push = true
  }
}
```

---

### **Authors**

Maintained by [David Essien](https://davidessien.com).

---

### **License**

This project is licensed under the MIT License.
