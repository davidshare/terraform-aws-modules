# AWS IAM Role Policy Terraform Module

## Description

This Terraform module creates an AWS IAM inline policy and attaches it to a specified IAM role.

## Features

- Attach an inline policy to an existing IAM role.
- Leverage Terraform's `jsonencode()` or `aws_iam_policy_document` for consistent JSON policy formatting.

## Usage

```hcl
module "iam_role_policy" {
  source = "./modules/aws_iam_role_policy"

  name   = "example_policy"
  role   = aws_iam_role.test_role.name
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "s3:ListBucket",
          "s3:GetObject",
        ]
        Effect   = "Allow"
        Resource = "*"
      },
    ]
  })
}
```

## Inputs

| Name     | Type   | Default | Description                                                                                                 |
| -------- | ------ | ------- | ----------------------------------------------------------------------------------------------------------- |
| `name`   | string | `null`  | The name of the IAM role policy. If omitted, a random unique name will be assigned.                         |
| `role`   | string | n/a     | **(Required)** The name of the IAM role to attach the policy to.                                            |
| `policy` | string | n/a     | **(Required)** The inline policy document. Use `jsonencode()` or `aws_iam_policy_document` for consistency. |

## Outputs

| Name              | Description                                                              |
| ----------------- | ------------------------------------------------------------------------ |
| `policy_id`       | The ID of the IAM role policy, in the form `role_name:role_policy_name`. |
| `policy_name`     | The name of the IAM role policy.                                         |
| `policy_document` | The policy document attached to the role.                                |
| `associated_role` | The name of the role associated with the policy.                         |

## Notes

1. **Incompatibility:** This module is incompatible with using the `inline_policy` argument in the `aws_iam_role` resource. Avoid using both simultaneously to prevent Terraform configuration conflicts.
2. **JSON Policies:** Use `jsonencode()` or the `aws_iam_policy_document` data source for policy consistency and reliability.

## License

This module is released under the MIT License.
