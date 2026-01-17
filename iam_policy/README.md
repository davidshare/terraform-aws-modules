# AWS IAM Policy Terraform Module

## Brief Description

This module manages an **AWS IAM managed policy** using the `aws_iam_policy` resource.

It provides full control over policy creation, naming, tagging, and lifecycle behavior,
while encouraging best practices for policy document generation.

---

## Why This Module Exists

IAM policies are **shared infrastructure primitives**:

- They outlive individual roles and users
- They are attached in multiple places
- They must remain stable and auditable

This module intentionally focuses only on **policy creation**, not attachment.

---

## Usage

```hcl
module "iam_policy" {
  source = "./iam_policy"

  name        = "ec2-read-only"
  description = "Read-only access to EC2 APIs"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect   = "Allow"
        Action   = ["ec2:Describe*"]
        Resource = "*"
      }
    ]
  })

  tags = {
    Environment = "prod"
    Owner       = "platform"
  }
}
```

---

## Requirements

| Name         | Version   |
| ------------ | --------- |
| Terraform    | >= 1.7.5  |
| AWS Provider | >= 5.77.0 |

---

## Providers

| Name | Source    | Version   |
| ---- | --------- | --------- |
| aws  | HashiCorp | >= 5.77.0 |

---

## Features

- Full support for **all aws_iam_policy arguments**
- Safe handling of AWS eventual consistency
- Clean separation of **policy creation** from **policy attachment**
- Compatible with provider `default_tags`

---

## Module Files

| File           | Description                    |
| -------------- | ------------------------------ |
| `main.tf`      | IAM policy resource definition |
| `variables.tf` | Input variables                |
| `outputs.tf`   | Exported attributes            |
| `README.md`    | Module documentation           |

---

## Inputs

| Variable                            | Description          | Type        | Default | Required |
| ----------------------------------- | -------------------- | ----------- | ------- | -------- |
| `name`                              | Policy name          | string      | null    | No       |
| `name_prefix`                       | Name prefix          | string      | null    | No       |
| `path`                              | IAM path             | string      | "/"     | No       |
| `description`                       | Policy description   | string      | null    | No       |
| `policy`                            | JSON policy document | string      | —       | Yes      |
| `tags`                              | Resource tags        | map(string) | {}      | No       |
| `delay_after_policy_creation_in_ms` | Consistency delay    | number      | null    | No       |

---

## Outputs

| Output             | Description                  |
| ------------------ | ---------------------------- |
| `arn`              | Policy ARN                   |
| `id`               | Policy ARN                   |
| `policy_id`        | Stable AWS policy ID         |
| `attachment_count` | Number of attachments        |
| `policy`           | JSON policy document         |
| `tags_all`         | All tags including inherited |

---

## Importing Existing Policies

### Terraform v1.12.0+ (Identity Import)

```hcl
import {
  to = aws_iam_policy.this
  identity = {
    arn = "arn:aws:iam::123456789012:policy/UsersManageOwnCredentials"
  }
}
```

### Terraform v1.5.0+ (ARN Import)

```hcl
import {
  to = aws_iam_policy.this
  id = "arn:aws:iam::123456789012:policy/UsersManageOwnCredentials"
}
```

### CLI Import

```bash
terraform import \
  aws_iam_policy.this \
  arn:aws:iam::123456789012:policy/UsersManageOwnCredentials
```

---

## Common Mistakes to Avoid

- Writing raw JSON instead of using `jsonencode`
- Re-creating policies instead of importing them
- Attaching policies inside the same module
- Treating IAM policies as disposable resources

---

## Design Philosophy

This module follows **strict IAM separation of concerns**:

- Policies define _what is allowed_
- Attachments define _who gets it_
- Roles, users, and groups remain independent

This keeps IAM predictable, auditable, and scalable.

---

## Author

Maintained by **David Essien**
[https://davidessien.com](https://davidessien.com)

---

## License

MIT License
