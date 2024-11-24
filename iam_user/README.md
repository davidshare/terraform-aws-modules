### AWS IAM User Terraform Module

**Brief Description**  
The AWS IAM User Terraform Module is designed to create and manage IAM users within AWS. It allows you to define attributes like the user name, path, permissions boundary, and tags, and manage their lifecycle through Terraform. This module supports advanced features like forced destruction of users with unmanaged access keys, login profiles, or MFA devices.

---

### Usage

To use this module in your Terraform configuration, reference it as shown below:

```hcl
module "iam_user" {
  source = "./iam_user"

  name = "my-iam-user"
  path = "/admins/"
  force_destroy = true
}
```

**Explanation of Key Parameters**:

- `name`: The desired name for the IAM user. This is a required parameter.
- `path`: The desired path for the IAM user. The default value is `/`.
- `force_destroy`: If set to `true`, the IAM user will be destroyed even if it has non-Terraform-managed access keys or MFA devices. Default is `false`.
- `permissions_boundary`: The ARN of the policy used as the permissions boundary for the user. This is optional.

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

- **Create IAM Users**: Allows you to create IAM users with specified configurations.
- **Force Destroy**: Option to destroy users even if they have non-Terraform-managed resources.
- **Permissions Boundary**: Attach a policy as a permissions boundary to the IAM user.
- **Tagging**: Add custom tags to IAM users for better resource management.

---

### Explanation of Files

| **File**       | **Description**                                               |
| -------------- | ------------------------------------------------------------- |
| `main.tf`      | Defines the `aws_iam_user` resource and its configuration.    |
| `variables.tf` | Contains input variables for creating the IAM user.           |
| `outputs.tf`   | Defines the output values like user name, ARN, and unique ID. |
| `README.md`    | Documentation for the IAM user Terraform module.              |

---

### Inputs

| **Variable**           | **Description**                                                                           | **Type**      | **Default** | **Required** |
| ---------------------- | ----------------------------------------------------------------------------------------- | ------------- | ----------- | ------------ |
| `name`                 | The desired name for the IAM user.                                                        | `string`      |             | Yes          |
| `path`                 | The desired path for the IAM user. Default is `/`.                                        | `string`      | `/`         | No           |
| `force_destroy`        | When set to `true`, destroy the user even if it has unmanaged access keys or MFA devices. | `bool`        | `false`     | No           |
| `permissions_boundary` | The ARN of the policy used to set the permissions boundary for the user.                  | `string`      | `null`      | No           |
| `tags`                 | A map of tags to add to the IAM user resource.                                            | `map(string)` | `{}`        | No           |

---

### Outputs

| **Output**  | **Description**                                  |
| ----------- | ------------------------------------------------ |
| `name`      | The name of the IAM user.                        |
| `arn`       | The ARN assigned by AWS for this IAM user.       |
| `unique_id` | The unique ID assigned by AWS for this IAM user. |

---

### Example Usage

#### Basic IAM User Creation

```hcl
module "iam_user_basic" {
  source = "./iam_user"

  name = "basic-user"
}
```

#### IAM User with Permissions Boundary and Forced Destroy

```hcl
module "iam_user_advanced" {
  source = "./iam_user"

  name                 = "advanced-user"
  path                 = "/admins/"
  force_destroy        = true
  permissions_boundary = "arn:aws:iam::aws:policy/AdministratorAccess"
}
```

---

### Authors

This module is maintained by [David Essien](https://davidessien.com).

---

### License

This module is licensed under the MIT License. See [LICENSE](LICENSE) for more information.
