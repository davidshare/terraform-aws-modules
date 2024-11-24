# AWS Terraform Module: IAM Instance Profile

## Brief Description

This Terraform module is used to create and manage an IAM instance profile in AWS. An IAM instance profile is associated with an EC2 instance, allowing it to assume IAM roles and gain the associated permissions. This module allows for the configuration of instance profiles, including assigning IAM roles, setting tags, and defining names or name prefixes.

---

## Usage

### Example Configuration

```hcl
module "iam_instance_profile" {
  source = "./iam_instance_profile"
  name   = "my-instance-profile"
  role   = "my-iam-role"
  tags   = {
    "Environment" = "production"
  }
}
```

### Explanation of Key Parameters

- **`name`**: The name of the IAM instance profile.
- **`name_prefix`**: Creates a unique name by beginning with the specified prefix. Conflicts with the `name` parameter (optional).
- **`path`**: The path to the instance profile (default is "/").
- **`role`**: The name of the IAM role to associate with the instance profile.
- **`tags`**: A map of tags to assign to the instance profile (optional).

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

## Features

- Creates an IAM instance profile in AWS.
- Associates an IAM role with the instance profile.
- Supports defining a unique name with an optional prefix.
- Allows adding tags to the instance profile.

---

## Explanation of Files

| **File**       | **Description**                                                                        |
| -------------- | -------------------------------------------------------------------------------------- |
| `main.tf`      | Defines the `aws_iam_instance_profile` resource for creating the IAM instance profile. |
| `variables.tf` | Declares input variables for configuring the IAM instance profile, role, and tags.     |
| `outputs.tf`   | Outputs the IAM instance profile ARN, ID, and unique ID.                               |
| `README.md`    | Documentation for the module.                                                          |

---

## Inputs

| **Variable**  | **Description**                                                                      | **Type**      | **Default** | **Required** |
| ------------- | ------------------------------------------------------------------------------------ | ------------- | ----------- | ------------ |
| `name`        | The name of the IAM instance profile.                                                | `string`      | N/A         | Yes          |
| `name_prefix` | Creates a unique name by beginning with the specified prefix. Conflicts with `name`. | `string`      | `null`      | No           |
| `path`        | The path to the instance profile. Defaults to `/`.                                   | `string`      | `/`         | No           |
| `role`        | The name of the IAM role to associate with the instance profile.                     | `string`      | N/A         | Yes          |
| `tags`        | A map of tags to assign to the instance profile.                                     | `map(string)` | `{}`        | No           |

---

## Outputs

| **Output**  | **Description**                                            |
| ----------- | ---------------------------------------------------------- |
| `arn`       | The ARN of the IAM instance profile.                       |
| `id`        | The ID of the IAM instance profile.                        |
| `unique_id` | The unique ID assigned by AWS to the IAM instance profile. |

---

## Example Usage

### Basic IAM Instance Profile

```hcl
module "iam_instance_profile_basic" {
  source = "./iam_instance_profile"
  name   = "basic-instance-profile"
  role   = "my-iam-role"
}
```

### IAM Instance Profile with Tags and Prefix

```hcl
module "iam_instance_profile_with_tags" {
  source     = "./iam_instance_profile"
  name       = "my-instance-profile"
  role       = "my-iam-role"
  name_prefix = "prod-"
  tags = {
    "Environment" = "production"
    "Project"     = "web-app"
  }
}
```

---

## Authors

This module is maintained by [David Essien](https://davidessien.com).

---

## License

This project is licensed under the MIT License. See `LICENSE` for more information.
