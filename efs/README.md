### AWS Terraform Module: EFS (Elastic File System)

This Terraform module provisions an AWS Elastic File System (EFS) and its associated mount targets. EFS provides scalable, elastic file storage for use with AWS services and on-premises resources, enabling shared storage across multiple resources.

---

### Usage

```hcl
module "efs" {
  source                        = "./path/to/efs"
  creation_token                = "my-efs"
  performance_mode              = "generalPurpose"
  throughput_mode               = "bursting"
  provisioned_throughput_in_mibps = null
  encrypted                     = true
  kms_key_id                    = "arn:aws:kms:us-east-1:123456789012:key/example-key-id"
  subnet_ids                    = ["subnet-abc123", "subnet-def456"]
  security_group_ids            = ["sg-123abc", "sg-456def"]
  tags = {
    Environment = "Production"
    Project     = "FileStorage"
  }
}
```

#### Key Parameters:

- `creation_token`: Unique identifier for the file system.
- `performance_mode`: Defines the performance mode (e.g., `generalPurpose`, `maxIO`).
- `throughput_mode`: Specifies throughput mode (`bursting` or `provisioned`).
- `subnet_ids`: Subnet IDs for creating EFS mount targets.
- `security_group_ids`: Security groups for access control.
- `kms_key_id`: ARN of the KMS encryption key (used if `encrypted` is set to `true`).

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

- Creates an EFS file system with configurable encryption and performance settings.
- Supports both bursting and provisioned throughput modes.
- Automatically provisions mount targets for specified subnets.
- Integrates with KMS for encryption when enabled.
- Flexible tagging for resource organization.

---

### Explanation of Files

| File           | Description                                             |
| -------------- | ------------------------------------------------------- |
| `main.tf`      | Defines the EFS file system and mount target resources. |
| `variables.tf` | Declares the module's input variables.                  |
| `outputs.tf`   | Specifies the outputs provided by the module.           |
| `README.md`    | Documentation for the module.                           |

---

### Inputs

| Variable                          | Description                                                                      | Type           | Default          | Required |
| --------------------------------- | -------------------------------------------------------------------------------- | -------------- | ---------------- | -------- |
| `creation_token`                  | A unique identifier for the EFS.                                                 | `string`       | -                | Yes      |
| `performance_mode`                | Defines the file system performance mode.                                        | `string`       | `generalPurpose` | No       |
| `throughput_mode`                 | Specifies throughput mode (`bursting` or `provisioned`).                         | `string`       | `bursting`       | No       |
| `provisioned_throughput_in_mibps` | Provisioned throughput in MiB/s (only used if throughput mode is `provisioned`). | `number`       | `null`           | No       |
| `encrypted`                       | Enables encryption of the file system if set to `true`.                          | `bool`         | `false`          | No       |
| `kms_key_id`                      | ARN of the KMS encryption key (used when `encrypted` is `true`).                 | `string`       | `null`           | No       |
| `subnet_ids`                      | Subnet IDs for creating mount targets.                                           | `list(string)` | -                | Yes      |
| `security_group_ids`              | Security groups to associate with the EFS mount targets.                         | `list(string)` | -                | Yes      |
| `tags`                            | Map of tags to apply to all resources.                                           | `map(string)`  | `{}`             | No       |

---

### Outputs

| Output            | Description                 |
| ----------------- | --------------------------- |
| `file_system_id`  | ID of the EFS file system.  |
| `file_system_arn` | ARN of the EFS file system. |
| `mount_targets`   | List of mount target IDs.   |

---

### Example Usage

#### Scenario 1: Basic EFS with Default Configuration

```hcl
module "efs_basic" {
  source             = "./path/to/efs"
  creation_token     = "basic-efs"
  subnet_ids         = ["subnet-xyz123"]
  security_group_ids = ["sg-xyz123"]
}
```

#### Scenario 2: Encrypted EFS with Provisioned Throughput

```hcl
module "efs_encrypted" {
  source                        = "./path/to/efs"
  creation_token                = "encrypted-efs"
  encrypted                     = true
  kms_key_id                    = "arn:aws:kms:us-west-2:123456789012:key/example-key-id"
  throughput_mode               = "provisioned"
  provisioned_throughput_in_mibps = 1024
  subnet_ids                    = ["subnet-abc123", "subnet-def456"]
  security_group_ids            = ["sg-123abc"]
}
```

---

### Authors

Module is maintained by [David Essien](https://davidessien.com).

---

### License

This project is licensed under the MIT License. See `LICENSE` for details.
