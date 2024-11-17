# AWS IAM Policy Document Terraform Module

This module generates an AWS IAM policy document in JSON format, supporting multiple statements in a single document. It can handle various configurations like actions, conditions, resources, principals, and more.

## Usage

### Example

```hcl
module "iam_policy_document" {
  source = "./path/to/this/module"

  version = "2012-10-17"
  statements = [
    {
      sid               = "SidExample1"
      actions           = ["s3:ListBucket"]
      effect            = "Allow"
      resources         = ["arn:aws:s3:::example-bucket"]
      not_actions       = []
      not_resources     = []
      not_principals    = []
      condition_test    = "StringEquals"
      condition_variable = "s3:prefix"
      condition_values  = ["home/"]
      principals        = [
        {
          type        = "AWS"
          identifiers = ["arn:aws:iam::123456789012:role/example-role"]
        }
      ]
    },
    {
      sid               = "SidExample2"
      actions           = ["s3:GetObject"]
      effect            = "Allow"
      resources         = ["arn:aws:s3:::example-bucket/*"]
      not_actions       = []
      not_resources     = []
      not_principals    = []
      condition_test    = "StringEquals"
      condition_variable = "s3:prefix"
      condition_values  = ["home/"]
      principals        = [
        {
          type        = "AWS"
          identifiers = ["arn:aws:iam::123456789012:role/example-role"]
        }
      ]
    }
  ]
}
```

### Module Inputs

| Name                        | Description                                                      | Type           | Default      |
| --------------------------- | ---------------------------------------------------------------- | -------------- | ------------ |
| `aws_region`                | The AWS region where resources will be managed.                  | `string`       | `us-west-2`  |
| `version`                   | IAM policy document version.                                     | `string`       | `2012-10-17` |
| `statements`                | List of IAM policy statements to include in the policy document. | `list(object)` | `[]`         |
| `source_policy_documents`   | List of source IAM policy documents to be merged.                | `list(string)` | `[]`         |
| `override_policy_documents` | List of override IAM policy documents.                           | `list(string)` | `[]`         |

### Outputs

- `policy_json`: The generated IAM policy document in JSON format.
- `minified_policy_json`: The generated IAM policy document in minified JSON format.

### Example Policy Document

```json
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "SidExample1",
      "Effect": "Allow",
      "Action": "s3:ListBucket",
      "Resource": "arn:aws:s3:::example-bucket"
    },
    {
      "Sid": "SidExample2",
      "Effect": "Allow",
      "Action": "s3:GetObject",
      "Resource": "arn:aws:s3:::example-bucket/*"
    }
  ]
}
```
