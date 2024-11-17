# Terraform AWS IAM Instance Profile Module

This module creates an AWS IAM instance profile using Terraform. It provides a convenient way to manage EC2 instance profiles with associated roles and policies.

## Table of Contents

- [Terraform AWS IAM Instance Profile Module](#terraform-aws-iam-instance-profile-module)
  - [Table of Contents](#table-of-contents)
  - [Features](#features)
  - [Usage](#usage)
  - [Arguments](#arguments)
    - [Required](#required)
    - [Optional](#optional)
  - [Outputs](#outputs)
  - [Examples](#examples)
  - [Modules](#modules)
  - [Requirements](#requirements)
  - [Providers](#providers)
  - [Resources](#resources)
  - [Inputs](#inputs)
  - [Outputs](#outputs-1)
  - [Maintainers](#maintainers)

## Features

- Creates an IAM instance profile with associated role and policies
- Supports custom policies and managed AWS policies
- Allows creation of inline policies
- Generates Terraform outputs for easy reference

## Usage

Basic usage:

```hcl
module "iam_instance_profile" {
  source = "path/to/module"

  name        = "my-instance-profile"
  description = "My EC2 instance profile"

  roles = [
    {
      name     = "ec2-role"
      policies = ["AmazonEC2FullAccess"]
    }
  ]
}
```

## Arguments

### Required

- `name` - (string) The name of the instance profile
- `description` - (string) Description of the instance profile

### Optional

- `roles` - (list of objects) List of roles to attach to the instance profile
- `create_policies` - (bool) Whether to create inline policies
- `policy_statements` - (list of objects) Inline policy statements
- `policy_arns` - (list of strings) ARNs of managed policies to attach

## Outputs

- `instance_profile_id` - ID of the created instance profile
- `role_ids` - IDs of the attached roles
- `attached_policy_arns` - ARNs of attached policies

## Examples

1. Basic example with single role and managed policy:

```hcl
module "example" {
  source = "path/to/module"

  name        = "my-example-profile"
  description = "Example instance profile"

  roles = [
    {
      name     = "example-role"
      policies = ["AWSReservedSSO_AWSAdministratorAccessRole"]
    }
  ]
}
```

2. Example with multiple roles and custom inline policy:

```hcl
module "advanced_example" {
  source = "path/to/module"

  name        = "multi-role-profile"
  description = "Advanced instance profile with multiple roles"

  roles = [
    {
      name     = "admin-role"
      policies = ["AmazonEC2FullAccess", "AWSLambda_FullAccess"]
    },
    {
      name     = "read-only-role"
      policies = ["AmazonS3ReadOnlyAccess"]
    }
  ]

  create_policies = true
  policy_statements = [
    {
      sid       = "AllowS3Read"
      effect    = "Allow"
      actions   = ["s3:GetObject", "s3:ListBucket"]
      resources = ["arn:aws:s3:::my-bucket/*", "arn:aws:s3:::my-bucket"]
    }
  ]
}
```

## Modules

This module does not use any nested modules.

## Requirements

| Name      | Version   |
| --------- | --------- |
| terraform | >= 0.12.0 |
| aws       | ~> 4.0    |

## Providers

| Name | Version |
| ---- | ------- |
| aws  | n       |

## Resources

| Name                           | Type     |
| ------------------------------ | -------- |
| aws_iam_instance_profile       | resource |
| aws_iam_role                   | resource |
| aws_iam_role_policy            | resource |
| aws_iam_role_policy_attachment | resource |

## Inputs

| Name              | Description                                     | Type                                                                                                                                                                                  | Default | Required |
| ----------------- | ----------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ------- | :------: |
| name              | The name of the instance profile                | string                                                                                                                                                                                | n       |   yes    |
| description       | Description of the instance profile             | string                                                                                                                                                                                | ""      |    no    |
| roles             | List of roles to attach to the instance profile | list(object({name = string, policies = list(string)}))                                                                                                                                | []      |    no    |
| create_policies   | Whether to create inline policies               | bool                                                                                                                                                                                  | false   |    no    |
| policy_statements | Inline policy statements                        | list(object({sid = string, effect = string, actions = list(string), resources = list(string), conditions = list(object({test = string, variable = string, values = list(string)}))})) | []      |    no    |
| policy_arns       | ARNs of managed policies to attach              | list(string)                                                                                                                                                                          | []      |    no    |

## Outputs

| Name                 | Description                        |
| -------------------- | ---------------------------------- |
| instance_profile_id  | ID of the created instance profile |
| role_ids             | IDs of the attached roles          |
| attached_policy_arns | ARNs of attached policies          |

## Maintainers

- Your Name <your.email@example.com>
