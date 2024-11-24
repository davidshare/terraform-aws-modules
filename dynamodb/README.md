# AWS DynamoDB Table Terraform Module

This Terraform module creates and manages an AWS DynamoDB table with support for global/local secondary indexes, stream configurations, TTL, and encryption options.

---

## **Usage**

```hcl
module "dynamodb_table" {
  source               = "./path-to-module/dynamodb"
  name                 = "example-dynamodb-table"
  billing_mode         = "PAY_PER_REQUEST"
  hash_key             = "partitionKey"
  range_key            = "sortKey"
  attributes           = [
    { name = "partitionKey", type = "S" },
    { name = "sortKey", type = "N" }
  ]
  global_secondary_indexes = [
    {
      name            = "GSI-1",
      hash_key        = "gsiPartitionKey",
      projection_type = "ALL"
    }
  ]
  ttl = {
    enabled        = true,
    attribute_name = "ttlAttribute"
  }
  stream_enabled      = true
  stream_view_type    = "NEW_AND_OLD_IMAGES"
  server_side_encryption = {
    enabled     = true
    kms_key_arn = "arn:aws:kms:region:account-id:key/key-id"
  }
  tags = {
    Environment = "Production"
    Project     = "MyApp"
  }
}
```

### Key Parameters in the Example

- **`name`**: Unique name of the DynamoDB table.
- **`hash_key`**: Partition key attribute.
- **`range_key`**: Sort key attribute (optional).
- **`attributes`**: Attribute definitions for hash and range keys.
- **`stream_enabled` & `stream_view_type`**: Enables DynamoDB Streams with desired view type.
- **`server_side_encryption`**: Specifies encryption at rest options.
- **`ttl`**: Configures Time to Live (TTL) on items.

---

## **Requirements**

| Requirement  | Version  |
| ------------ | -------- |
| Terraform    | >= 1.3.0 |
| AWS Provider | >= 5.0.0 |

---

## **Providers**

| Provider | Source    | Version  |
| -------- | --------- | -------- |
| `aws`    | HashiCorp | >= 5.0.0 |

---

## **Features**

- **Key-Value Table Creation**: Supports hash and range keys for a DynamoDB table.
- **Secondary Indexes**: Add global and local secondary indexes.
- **DynamoDB Streams**: Enables streams for data changes.
- **Time-to-Live (TTL)**: Automatically deletes expired items.
- **Encryption**: Configures server-side encryption with optional KMS keys.

---

## **Explanation of Files**

| File           | Description                                                         |
| -------------- | ------------------------------------------------------------------- |
| `main.tf`      | Contains the primary resource configuration for the DynamoDB table. |
| `variables.tf` | Defines input variables for the module.                             |
| `outputs.tf`   | Declares the outputs of the module.                                 |
| `README.md`    | Documentation for the module.                                       |

---

## **Inputs**

| Name                       | Type           | Default             | Required | Description                                                   |
| -------------------------- | -------------- | ------------------- | -------- | ------------------------------------------------------------- |
| `name`                     | `string`       | N/A                 | Yes      | Unique name for the DynamoDB table.                           |
| `billing_mode`             | `string`       | `"PAY_PER_REQUEST"` | No       | Billing mode (`PAY_PER_REQUEST` or `PROVISIONED`).            |
| `read_capacity`            | `number`       | `null`              | No       | Read capacity (required if `billing_mode` is `PROVISIONED`).  |
| `write_capacity`           | `number`       | `null`              | No       | Write capacity (required if `billing_mode` is `PROVISIONED`). |
| `hash_key`                 | `string`       | N/A                 | Yes      | Hash (partition) key for the table.                           |
| `range_key`                | `string`       | `null`              | No       | Range (sort) key for the table.                               |
| `attributes`               | `list(object)` | N/A                 | Yes      | List of attribute definitions for the table.                  |
| `global_secondary_indexes` | `list(object)` | `[]`                | No       | Definitions for global secondary indexes.                     |
| `local_secondary_indexes`  | `list(object)` | `[]`                | No       | Definitions for local secondary indexes.                      |
| `ttl`                      | `object`       | `null`              | No       | TTL configuration with `enabled` and `attribute_name`.        |
| `stream_enabled`           | `bool`         | `false`             | No       | Whether to enable DynamoDB Streams.                           |
| `stream_view_type`         | `string`       | `null`              | No       | Stream view type (`NEW_IMAGE`, `OLD_IMAGE`, etc.).            |
| `server_side_encryption`   | `object`       | `null`              | No       | Server-side encryption configuration (optional KMS key).      |
| `tags`                     | `map(string)`  | `{}`                | No       | Tags to apply to the resource.                                |

---

## **Outputs**

| Name         | Description                                                        |
| ------------ | ------------------------------------------------------------------ |
| `arn`        | ARN of the DynamoDB table.                                         |
| `id`         | ID of the DynamoDB table.                                          |
| `stream_arn` | ARN of the Table Stream (available if `stream_enabled` is `true`). |

---

## **Example Usage**

### Example 1: Basic Table with TTL

```hcl
module "basic_dynamodb_table" {
  source     = "./path-to-module/dynamodb"
  name       = "basic-table"
  hash_key   = "id"
  attributes = [{ name = "id", type = "S" }]
  ttl = {
    enabled        = true
    attribute_name = "expiry"
  }
}
```

### Example 2: Table with Secondary Indexes and Streams

```hcl
module "advanced_dynamodb_table" {
  source               = "./path-to-module/dynamodb"
  name                 = "advanced-table"
  hash_key             = "userId"
  range_key            = "timestamp"
  attributes           = [
    { name = "userId", type = "S" },
    { name = "timestamp", type = "N" }
  ]
  global_secondary_indexes = [
    {
      name            = "GSI1",
      hash_key        = "userId",
      projection_type = "ALL"
    }
  ]
  stream_enabled      = true
  stream_view_type    = "NEW_AND_OLD_IMAGES"
  tags = {
    Environment = "Dev"
  }
}
```

---

## **Authors**

Module maintained by [David Essien](https://davidessien.com).

---

## **License**

This project is licensed under the MIT License.
