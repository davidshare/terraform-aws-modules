### AWS IAM Role Terraform Module

**Brief Description**  
The AWS IAM Role Terraform Module allows you to create and manage IAM roles in AWS, including options for defining role descriptions, session duration, and assume role policies. This module is useful for configuring IAM roles with custom permissions and tags in a Terraform-managed AWS infrastructure.

---

### Usage

To use this module in your Terraform configuration, reference it as shown below:

```hcl
module "iam_role" {
  source = "./iam_role"

  name               = "my-iam-role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action    = "sts:AssumeRole"
        Effect    = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      }
    ]
  })
  tags = {
    Environment = "Production"
    Project     = "WebApp"
  }
}
```

**Explanation of Key Parameters**:

- `name`: The name of the IAM role. This is a required parameter.
- `assume_role_policy`: A JSON string defining the policy that grants entities permission to assume this role. This is required.
- `tags`: Optional key-value tags that can be assigned to the IAM role.

---

### Requirements

| Name         | Version   |
| ------------ | --------- |
| Terraform    | >= 1.7.5  |
| AWS Provider | >= 5.77.0 |

---

### Providers

| Provider | Source    | Version   |
| -------- | --------- | --------- |
| `aws`    | HashiCorp | >= 5.77.0 |

---

### Features

- **Custom Role Names**: Define a custom IAM role name or use a prefix.
- **Assume Role Policy**: Set the assume role policy to specify trusted entities that can assume the role.
- **Session Duration**: Configure the maximum session duration for role assumptions.
- **Permissions Boundary**: Optionally define a permissions boundary for role permissions.
- **Tags**: Add custom tags to the IAM role for organizational purposes.

---

### Explanation of Files

| **File**       | **Description**                                                 |
| -------------- | --------------------------------------------------------------- |
| `main.tf`      | Defines the IAM role resource and its configuration.            |
| `variables.tf` | Contains input variables for customizing the IAM role creation. |
| `outputs.tf`   | Defines the output values such as IAM role ID, ARN, etc.        |
| `README.md`    | Documentation for the IAM role Terraform module.                |

---

### Inputs

| **Variable**            | **Description**                                                      | **Type**      | **Default** | **Required** |
| ----------------------- | -------------------------------------------------------------------- | ------------- | ----------- | ------------ |
| `name`                  | Friendly name of the IAM role. Conflicts with `name_prefix`.         | `string`      | `null`      | Yes          |
| `name_prefix`           | Prefix for the IAM role name. Conflicts with `name`.                 | `string`      | `null`      | No           |
| `path`                  | Path to the IAM role.                                                | `string`      | `/`         | No           |
| `description`           | Description of the IAM role.                                         | `string`      | `null`      | No           |
| `assume_role_policy`    | The assume role policy in JSON format.                               | `string`      |             | Yes          |
| `max_session_duration`  | Maximum session duration (in seconds) for the IAM role.              | `number`      | `3600`      | No           |
| `permissions_boundary`  | ARN of the policy used as the permissions boundary for the IAM role. | `string`      | `null`      | No           |
| `force_detach_policies` | Whether to force detaching policies before destroying the role.      | `bool`        | `false`     | No           |
| `tags`                  | Key-value mapping of tags for the IAM role.                          | `map(string)` | `{}`        | No           |

---

### Outputs

| **Output**  | **Description**                |
| ----------- | ------------------------------ |
| `id`        | The ID of the IAM role.        |
| `arn`       | The ARN of the IAM role.       |
| `name`      | The name of the IAM role.      |
| `unique_id` | The unique ID of the IAM role. |

---

### Example Usage

#### Simple Role Creation

```hcl
module "iam_role_simple" {
  source = "./iam_role"

  name               = "my-simple-iam-role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action    = "sts:AssumeRole"
        Effect    = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      }
    ]
  })
}
```

#### Role with Permissions Boundary and Tags

```hcl
module "iam_role_with_permissions_boundary" {
  source = "./iam_role"

  name               = "my-iam-role-with-boundary"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action    = "sts:AssumeRole"
        Effect    = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      }
    ]
  })
  permissions_boundary = "arn:aws:iam::aws:policy/AdministratorAccess"
  tags = {
    Environment = "Dev"
    Team        = "DevOps"
  }
}
```

---

### Authors

This module is maintained by [David Essien](https://davidessien.com).

---

### License

This module is licensed under the MIT License. See [LICENSE](LICENSE) for more information.
