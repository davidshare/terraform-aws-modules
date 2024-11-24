### AWS KMS Key Terraform Module

**Brief Description**  
The AWS KMS Key Terraform Module simplifies the management of AWS Key Management Service (KMS) keys. It allows for the creation of symmetric or asymmetric keys, enables key rotation, and manages associated key policies. This module also supports adding aliases for easier key management and tagging for better organization.

---

### Usage

To use this module in your Terraform configuration, reference it as shown below:

```hcl
module "kms" {
  source = "./kms"

  description               = "MyKMSKey"
  deletion_window_in_days   = 30
  key_usage                 = "ENCRYPT_DECRYPT"
  customer_master_key_spec  = "SYMMETRIC_DEFAULT"
  is_enabled                = true
  enable_key_rotation       = true
  policy                    = null
  tags = {
    Name = "MyKMSKey"
    Environment = "Production"
  }
}
```

**Explanation of Key Parameters**:

- `description`: A description of the key, visible in the AWS console.
- `deletion_window_in_days`: The duration in days after which the key is deleted after resource destruction. Defaults to 30 days.
- `key_usage`: The intended use of the key, such as `ENCRYPT_DECRYPT`. Defaults to `ENCRYPT_DECRYPT`.
- `customer_master_key_spec`: The type of key and the encryption or signing algorithms it supports. Defaults to `SYMMETRIC_DEFAULT`.
- `is_enabled`: Whether the key is enabled. Defaults to `true`.
- `enable_key_rotation`: Whether key rotation is enabled. Defaults to `true`.
- `policy`: The policy in JSON format for the key, or `null` if no custom policy is provided.
- `tags`: A map of tags to apply to the key resource.

---

### Requirements

| **Terraform Version** | **AWS Provider Version** |
| --------------------- | ------------------------ |
| `>= 1.0.0`            | `>= 3.0.0`               |

---

### Providers

| **Provider** | **Version** |
| ------------ | ----------- |
| `aws`        | `>= 3.0.0`  |

---

### Features

- **Key Creation**: Allows the creation of symmetric or asymmetric KMS keys with specified configurations.
- **Key Rotation**: Supports automatic key rotation for enhanced security.
- **Key Aliases**: Creates an alias for the KMS key for easier management.
- **Tagging**: Custom tags can be added to the KMS key for better resource organization and management.
- **Custom Key Policy**: The ability to provide a custom key policy in JSON format to control access and permissions for the key.

---

### Explanation of Files

| **File**       | **Description**                                                                           |
| -------------- | ----------------------------------------------------------------------------------------- |
| `main.tf`      | Defines the `aws_kms_key` and `aws_kms_alias` resources, along with their configurations. |
| `variables.tf` | Contains input variables like key description, policy, and rotation settings.             |
| `outputs.tf`   | Defines the output values such as key ID, ARN, and alias ARN for further use.             |
| `README.md`    | Documentation for the KMS Key Terraform module.                                           |

---

### Inputs

| **Variable**               | **Description**                                               | **Type**      | **Default**         | **Required** |
| -------------------------- | ------------------------------------------------------------- | ------------- | ------------------- | ------------ |
| `description`              | The description of the KMS key.                               | `string`      |                     | Yes          |
| `deletion_window_in_days`  | The duration in days before key is deleted after destruction. | `number`      | `30`                | No           |
| `key_usage`                | The intended use of the KMS key.                              | `string`      | `ENCRYPT_DECRYPT`   | No           |
| `customer_master_key_spec` | Specifies whether the key is symmetric or asymmetric.         | `string`      | `SYMMETRIC_DEFAULT` | No           |
| `is_enabled`               | Whether the key is enabled or disabled.                       | `bool`        | `true`              | No           |
| `enable_key_rotation`      | Whether key rotation is enabled.                              | `bool`        | `true`              | No           |
| `policy`                   | A valid JSON policy document to attach to the key.            | `string`      | `null`              | No           |
| `tags`                     | A map of tags to apply to the KMS key.                        | `map(string)` | `{}`                | No           |

---

### Outputs

| **Output**  | **Description**                                 |
| ----------- | ----------------------------------------------- |
| `key_id`    | The globally unique identifier for the KMS key. |
| `key_arn`   | The ARN of the created KMS key.                 |
| `alias_arn` | The ARN of the KMS key alias.                   |

---

### Example Usage

#### Basic KMS Key Creation

```hcl
module "kms_basic" {
  source = "./kms"

  description = "MyKMSKey"
}
```

#### KMS Key with Key Rotation Disabled

```hcl
module "kms_no_rotation" {
  source = "./kms"

  description        = "NoRotationKMSKey"
  enable_key_rotation = false
}
```

#### KMS Key with Custom Policy

```hcl
module "kms_with_policy" {
  source = "./kms"

  description = "KMSWithCustomPolicy"
  policy      = <<EOT
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": "*",
      "Action": "kms:Encrypt",
      "Resource": "*"
    }
  ]
}
EOT
}
```

---

### Authors

This module is maintained by [David Essien](https://davidessien.com).

---

### License

This module is licensed under the MIT License. See [LICENSE](LICENSE) for more information.
