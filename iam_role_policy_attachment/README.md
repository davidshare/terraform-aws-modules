# AWS IAM Role Policy Attachment Terraform Module

## Brief Description

This Terraform module manages the attachment of an **AWS-managed or customer-managed IAM policy** to an **existing IAM role** using the `aws_iam_role_policy_attachment` resource.

The module is intentionally minimal to avoid permanent diffs and resource conflicts that commonly occur when IAM policy attachments are over-abstracted.

---

## ⚠️ Important Behavioral Notes (Read First)

This module **must not** be used together with:

- `aws_iam_policy_attachment`
- `aws_iam_role.managed_policy_arns`

Doing so will cause **permanent Terraform drift** because multiple resources will attempt to manage the same attachment state.

**Rule of thumb**:

> One IAM attachment = one Terraform resource

---

## Usage

```hcl
module "iam_role_policy_attachment" {
  source = "./iam_role_policy_attachment"

  role       = "my-iam-role"
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ReadOnlyAccess"
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

- Attach **AWS-managed or customer-managed** IAM policies
- Safe, drift-free attachment modeling
- Compatible with production IAM workflows
- Explicit ownership of IAM attachment lifecycle

---

## Module Files

| File           | Description                               |
| -------------- | ----------------------------------------- |
| `main.tf`      | Defines the IAM role policy attachment    |
| `variables.tf` | Input variables for role and policy ARN   |
| `outputs.tf`   | Exposes attachment inputs for composition |
| `README.md`    | Module documentation                      |

---

## Inputs

| Variable     | Description                   | Type     | Required |
| ------------ | ----------------------------- | -------- | -------- |
| `role`       | Name of the IAM role          | `string` | Yes      |
| `policy_arn` | ARN of the managed IAM policy | `string` | Yes      |

---

## Outputs

| Output       | Description         |
| ------------ | ------------------- |
| `role`       | IAM role name       |
| `policy_arn` | Attached policy ARN |

---

## Importing Existing Attachments

### Terraform v1.12.0+ (Identity Import)

```hcl
import {
  to = aws_iam_role_policy_attachment.this
  identity = {
    role       = "test-role"
    policy_arn = "arn:aws:iam::123456789012:policy/test-policy"
  }
}
```

### Terraform v1.5.0+ (Slash-separated ID)

```hcl
import {
  to = aws_iam_role_policy_attachment.this
  id = "test-role/arn:aws:iam::123456789012:policy/test-policy"
}
```

### CLI Import

```bash
terraform import \
  aws_iam_role_policy_attachment.this \
  test-role/arn:aws:iam::123456789012:policy/test-policy
```

---

## Common Mistakes to Avoid

- ❌ Using `managed_policy_arns` on `aws_iam_role`
- ❌ Mixing `aws_iam_policy_attachment` and this resource
- ❌ Trying to attach inline policies (this resource is **managed policies only**)

---

## Design Philosophy

This module follows **single-responsibility IAM design**:

- One attachment
- One policy
- One role
- No hidden behavior

This makes IAM behavior predictable, auditable, and safe at scale.

---

## Author

Maintained by **David Essien**
[https://davidessien.com](https://davidessien.com)

---

## License

MIT License
