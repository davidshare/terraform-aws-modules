# AWS Secrets Manager Secret Module

This Terraform module manages an **AWS Secrets Manager Secret**, including metadata and replication settings.

### Features:

1. **Dynamic Replication**:

   - Supports multiple replication blocks, each with optional KMS key configuration.

2. **Comprehensive Inputs and Outputs**:

   - Includes all resource arguments and exported attributes.

3. **Detailed Documentation**:
   - Provides usage examples for both basic and advanced configurations.

## Usage

### Basic Example

```hcl
module "secret" {
  source = "./modules/aws_secretsmanager_secret"

  name        = "example-secret"
  description = "Example secret for demonstration"
  tags = {
    Environment = "production"
    Application = "my-app"
  }
}
```

### Advanced Example with Replication

```hcl
module "secret_with_replication" {
  source = "./modules/aws_secretsmanager_secret"

  name                            = "replicated-secret"
  description                     = "A secret replicated across regions"
  kms_key_id                      = "arn:aws:kms:us-west-2:123456789012:key/example"
  force_overwrite_replica_secret  = true
  recovery_window_in_days         = 7
  tags = {
    Environment = "staging"
    Application = "my-app"
  }
  replica = [
    {
      region     = "us-east-1"
      kms_key_id = "arn:aws:kms:us-east-1:123456789012:key/example"
    },
    {
      region     = "eu-west-1"
    }
  ]
}
```

## Inputs

### Arguments

| Name                             | Type           | Default | Description                                                                |
| -------------------------------- | -------------- | ------- | -------------------------------------------------------------------------- |
| `description`                    | `string`       | `null`  | Description of the secret.                                                 |
| `kms_key_id`                     | `string`       | `null`  | ARN or ID of the KMS key used to encrypt the secret.                       |
| `name`                           | `string`       | `null`  | Friendly name of the secret. Conflicts with `name_prefix`.                 |
| `name_prefix`                    | `string`       | `null`  | Prefix for the secret name. Conflicts with `name`.                         |
| `policy`                         | `string`       | `null`  | JSON document representing a resource policy.                              |
| `recovery_window_in_days`        | `number`       | `30`    | Number of days AWS Secrets Manager waits before deleting the secret.       |
| `force_overwrite_replica_secret` | `bool`         | `false` | Overwrite an existing secret with the same name in the destination region. |
| `tags`                           | `map(string)`  | `{}`    | Key-value map of user-defined tags attached to the secret.                 |
| `replica`                        | `list(object)` | `[]`    | Configuration for secret replication. Each block must include `region`.    |

### Replica Attributes

| Key          | Type     | Required | Description                                                  |
| ------------ | -------- | -------- | ------------------------------------------------------------ |
| `region`     | `string` | Yes      | Region where the secret will be replicated.                  |
| `kms_key_id` | `string` | No       | KMS key in the destination region for encrypting the secret. |

## Outputs

| Name       | Description                                                     |
| ---------- | --------------------------------------------------------------- |
| `id`       | ARN of the secret.                                              |
| `arn`      | ARN of the secret.                                              |
| `replica`  | Attributes of replicas including status and last accessed date. |
| `tags_all` | Map of all tags, including inherited provider default tags.     |

## Notes

- If `kms_key_id` is not provided, the default KMS key (`aws/secretsmanager`) is used.
- To delete a secret immediately, set `recovery_window_in_days` to `0`.

## Authors

This module is maintained by [Your Name/Organization]. Contributions are welcome!
