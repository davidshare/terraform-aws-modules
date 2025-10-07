### AWS Terraform Module: ECR Repository

This Terraform module provisions and manages an Amazon Elastic Container Registry (ECR) repository. The module simplifies the creation of a secure repository for container images, enabling features such as image scanning and encryption.

---

### Usage

```hcl
module "ecr_repository" {
  source = "./path/to/ecr"

  name                 = "my-ecr-repo"
  image_tag_mutability = "IMMUTABLE"
  scan_on_push         = true
  encryption_type      = "KMS"
  kms_key              = "arn:aws:kms:region:account-id:key/key-id"
  tags = {
    Environment = "Production"
    Owner       = "Team A"
  }
}
```

#### Key Parameters:

- `name`: Specifies the name of the ECR repository.
- `image_tag_mutability`: Defines whether image tags are mutable or immutable. Default is `MUTABLE`.
- `scan_on_push`: Enables image scanning upon push for enhanced security.
- `encryption_type`: Specifies the encryption type (`AES256` or `KMS`).
- `kms_key`: ARN of the KMS key used for encryption when `encryption_type` is `KMS`.
- `tags`: Adds custom metadata tags to the repository.

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

### Features

- Creates an ECR repository with customizable configurations.
- Enables automated image scanning for vulnerability detection.
- Supports encryption with KMS or AES256.
- Flexible tagging for resource organization.

---

### Explanation of Files

| File           | Description                                        |
| -------------- | -------------------------------------------------- |
| `main.tf`      | Defines the ECR repository resource configuration. |
| `variables.tf` | Declares the module's input variables.             |
| `outputs.tf`   | Specifies the outputs provided by the module.      |
| `README.md`    | Documentation for the module.                      |

---

### Inputs

| Variable               | Description                                                  | Type          | Default   | Required |
| ---------------------- | ------------------------------------------------------------ | ------------- | --------- | -------- |
| `name`                 | Name of the repository.                                      | `string`      | -         | Yes      |
| `image_tag_mutability` | Tag mutability setting (`MUTABLE` or `IMMUTABLE`).           | `string`      | `MUTABLE` | No       |
| `scan_on_push`         | Enable scanning on image push.                               | `bool`        | `false`   | No       |
| `encryption_type`      | Encryption type for the repository (`AES256` or `KMS`).      | `string`      | `AES256`  | No       |
| `kms_key`              | ARN of the KMS key for encryption (required if using `KMS`). | `string`      | `null`    | No       |
| `tags`                 | Tags to assign to the repository.                            | `map(string)` | `{}`      | No       |

---

### Outputs

| Output        | Description                                   |
| ------------- | --------------------------------------------- |
| `url`         | The URL of the repository.                    |
| `arn`         | The ARN of the repository.                    |
| `registry_id` | The registry ID where the repository resides. |

---

### Example Usage

#### Scenario 1: Default Configuration

```hcl
module "ecr_default" {
  source = "./path/to/ecr"

  name = "default-repo"
}
```

#### Scenario 2: KMS Encryption with Scanning

```hcl
module "ecr_kms" {
  source = "./path/to/ecr"

  name                 = "secure-repo"
  encryption_type      = "KMS"
  kms_key              = "arn:aws:kms:region:account-id:key/key-id"
  scan_on_push         = true
}
```

---

### Authors

Module is maintained by [David Essien](https://davidessien.com).

---

### License

This project is licensed under the MIT License. See `LICENSE` for details.
