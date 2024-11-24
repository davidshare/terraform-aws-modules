# AWS Secrets Manager Secret Version Module

This Terraform module manages an **AWS Secrets Manager Secret Version**, enabling you to store and manage the values of secrets securely. This complements the `aws_secretsmanager_secret` module, which manages the secret metadata.

## Usage

### Simple String Value

```hcl
module "secret_version" {
  source = "./modules/aws_secretsmanager_secret_version"

  secret_id     = aws_secretsmanager_secret.example.id
  secret_string = "example-string-to-protect"
}
```

### Key-Value Pairs

```hcl
variable "example" {
  description = "Key-value pairs to store in the secret"
  type        = map(string)
  default = {
    key1 = "value1"
    key2 = "value2"
  }
}

module "secret_version" {
  source = "./modules/aws_secretsmanager_secret_version"

  secret_id     = aws_secretsmanager_secret.example.id
  secret_string = jsonencode(var.example)
}
```

### Binary Secret Value

```hcl
module "secret_version_binary" {
  source = "./modules/aws_secretsmanager_secret_version"

  secret_id     = aws_secretsmanager_secret.example.id
  secret_binary = base64encode("example-binary-data")
}
```

## Inputs

| Name             | Type           | Default | Description                                                                                |
| ---------------- | -------------- | ------- | ------------------------------------------------------------------------------------------ |
| `secret_id`      | `string`       | -       | Specifies the secret to which you want to add a new version. Accepts ARN or friendly name. |
| `secret_string`  | `string`       | `null`  | Text data to encrypt and store in this version. Required if `secret_binary` is not set.    |
| `secret_binary`  | `string`       | `null`  | Binary data (base64-encoded) to encrypt and store. Required if `secret_string` is not set. |
| `version_stages` | `list(string)` | `[]`    | List of staging labels for the secret version. Defaults to moving the `AWSCURRENT` label.  |

## Outputs

| Name                    | Description                                                                  |
| ----------------------- | ---------------------------------------------------------------------------- |
| `secret_version_id`     | The unique identifier of the secret version.                                 |
| `secret_version_stages` | The list of staging labels currently attached to this version of the secret. |

## Notes

- **Conflicts Between `secret_string` and `secret_binary`**: These arguments are mutually exclusive, so one must be set but not both.
- **Base64 Encoding for `secret_binary`**: Ensure that `secret_binary` values are properly encoded using `base64encode()` if you provide binary data.
- **Version Stages**: AWS automatically moves the `AWSCURRENT` label to new versions unless otherwise specified with `version_stages`.

## Authors

This module is maintained by [Your Name/Organization]. Contributions are welcome!

---

### Key Features:

1. **Supports All Arguments**:

   - `secret_id` to link to an existing secret.
   - `secret_string` or `secret_binary` for storing data securely.
   - Optional `version_stages` for controlling labels.

2. **Flexible Configuration**:

   - Use simple strings, key-value pairs (JSON), or binary data as needed.

3. **Detailed Documentation**:

   - Provides examples for all major use cases (simple strings, key-value pairs, binary secrets).

4. **Secure Practices**:
   - Encourages use of `jsonencode` for key-value secrets and `base64encode` for binary secrets.
