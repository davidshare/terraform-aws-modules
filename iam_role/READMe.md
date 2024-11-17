````markdown
# AWS IAM Role Terraform Module

## Description

This Terraform module creates and manages an AWS IAM Role with configurable parameters such as name, path, assume role policy, tags, and more. It also allows you to manage inline and managed policies associated with the role.

## Features

- Create an IAM Role with an optional description, name, and path.
- Attach inline policies or managed policies (deprecated options).
- Support for assume role policies and permissions boundaries.
- Configurable maximum session duration.
- Flexible tagging support.

## Usage

```hcl
module "iam_role" {
  source = "./modules/aws_iam_role"

  name                = "example-role"
  assume_role_policy  = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      },
    ]
  })
  description         = "An example IAM role"
  force_detach_policies = true
  max_session_duration = 3600
  tags = {
    Environment = "production"
    Team        = "devops"
  }
}
```
````

## Inputs

| Name                    | Type           | Default | Description                                                                |
| ----------------------- | -------------- | ------- | -------------------------------------------------------------------------- |
| `name`                  | `string`       | `null`  | Friendly name of the role. Conflicts with `name_prefix`.                   |
| `name_prefix`           | `string`       | `null`  | Prefix for the role name. Conflicts with `name`.                           |
| `path`                  | `string`       | `"/"`   | Path to the role.                                                          |
| `assume_role_policy`    | `string`       | n/a     | **(Required)** Policy that grants an entity permission to assume the role. |
| `description`           | `string`       | `null`  | Description of the role.                                                   |
| `force_detach_policies` | `bool`         | `false` | Whether to force detach policies before destroying the role.               |
| `inline_policies`       | `list(object)` | `[]`    | List of inline policies. Each object requires `name` and `policy` keys.    |
| `managed_policy_arns`   | `list(string)` | `[]`    | List of managed policy ARNs to attach.                                     |
| `max_session_duration`  | `number`       | `3600`  | Maximum session duration (in seconds) for the role.                        |
| `permissions_boundary`  | `string`       | `null`  | ARN of the policy used as the permissions boundary for the role.           |
| `tags`                  | `map(string)`  | `{}`    | Key-value mapping of tags for the role.                                    |

## Outputs

| Name        | Description               |
| ----------- | ------------------------- |
| `role_arn`  | The ARN of the IAM role.  |
| `role_name` | The name of the IAM role. |
| `role_id`   | The ID of the IAM role.   |

## Notes

1. When modifying the role name or path, set `force_detach_policies` to `true` to avoid `DeleteConflict` errors.
2. If you use `inline_policies` or `managed_policy_arns`, this resource will exclusively manage those policies. Avoid managing them via other methods like `aws_iam_policy_attachment`.
3. For consistent and error-free JSON policies, use `jsonencode()` or the `aws_iam_policy_document` data source.

## License

This module is released under the MIT License.

```

Let me know if you need any modifications!
```
