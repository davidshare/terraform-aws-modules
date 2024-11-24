### AWS IAM Role Policy Terraform Module

**Brief Description**  
The AWS IAM Role Policy Terraform Module is designed to manage inline policies for IAM roles in AWS. It allows you to attach a custom inline policy to an IAM role, either using a specified policy document or generating one dynamically using Terraform's built-in functions.

---

### Usage

To use this module in your Terraform configuration, reference it as shown below:

```hcl
module "iam_role_policy" {
  source = "./iam_role_policy"

  role   = "my-iam-role"
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action   = "s3:ListBucket"
        Effect   = "Allow"
        Resource = "arn:aws:s3:::my-bucket"
      }
    ]
  })
}
```

**Explanation of Key Parameters**:

- `role`: The name of the IAM role to which the policy will be attached. This is a required parameter.
- `policy`: The inline policy document, provided as a JSON string. This is required.

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

- **Attach Inline Policy**: Attach a custom inline policy to an IAM role.
- **Dynamic Policy Creation**: Use Terraform functions like `jsonencode()` or the `aws_iam_policy_document` data source to dynamically create policy documents.
- **Custom Role and Policy Names**: Specify either custom names or use prefixes for unique names.

---

### Explanation of Files

| **File**       | **Description**                                                      |
| -------------- | -------------------------------------------------------------------- |
| `main.tf`      | Defines the `aws_iam_role_policy` resource and its configuration.    |
| `variables.tf` | Contains input variables for defining the role policy configuration. |
| `outputs.tf`   | Defines the output values such as policy ID, name, and document.     |
| `README.md`    | Documentation for the IAM role policy Terraform module.              |

---

### Inputs

| **Variable**  | **Description**                                                                   | **Type** | **Default** | **Required** |
| ------------- | --------------------------------------------------------------------------------- | -------- | ----------- | ------------ |
| `name`        | The name of the role policy. If omitted, a random, unique name will be assigned.  | `string` | `null`      | No           |
| `name_prefix` | Creates a unique name beginning with the specified prefix. Conflicts with `name`. | `string` | `null`      | No           |
| `role`        | The name of the IAM role to attach the policy to.                                 | `string` |             | Yes          |
| `policy`      | The inline policy document as a JSON formatted string.                            | `string` |             | Yes          |

---

### Outputs

| **Output**        | **Description**                                                             |
| ----------------- | --------------------------------------------------------------------------- |
| `id`       | The ID of the IAM role policy, in the form of `role_name:role_policy_name`. |
| `name`     | The name of the IAM role policy.                                            |
| `document` | The policy document attached to the role.                                   |
| `associated_role` | The name of the role associated with the policy.                            |

---

### Example Usage

#### Basic Role Policy Attachment

```hcl
module "iam_role_policy_basic" {
  source = "./iam_role_policy"

  role   = "my-iam-role"
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action   = "s3:ListBucket"
        Effect   = "Allow"
        Resource = "arn:aws:s3:::my-bucket"
      }
    ]
  })
}
```

#### Role Policy with Prefix and Random Name

```hcl
module "iam_role_policy_random" {
  source = "./iam_role_policy"

  name_prefix = "my-policy-"
  role        = "my-iam-role"
  policy      = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action   = "s3:PutObject"
        Effect   = "Allow"
        Resource = "arn:aws:s3:::my-bucket/*"
      }
    ]
  })
}
```

---

### Authors

This module is maintained by [David Essien](https://davidessien.com).

---

### License

This module is licensed under the MIT License. See [LICENSE](LICENSE) for more information.
