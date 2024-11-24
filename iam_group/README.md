# AWS Terraform Module: IAM Group

## Brief Description

This AWS Terraform module creates and manages an IAM group within AWS, including the ability to add users and attach IAM policies to the group. The module simplifies the process of organizing IAM users into groups and managing their permissions through policy attachments.

---

## Usage

### Example Configuration

```hcl
module "iam_group" {
  source = "./iam_group"
  name   = "my-admin-group"
  users  = ["user1", "user2"]
  policies = [
    "arn:aws:iam::aws:policy/AdministratorAccess",
    "arn:aws:iam::aws:policy/PowerUserAccess"
  ]
}
```

### Explanation of Key Parameters

- **`name`**: The name of the IAM group.
- **`path`**: The path in which to create the IAM group (optional, default is "/").
- **`users`**: A list of IAM users to add to the group (optional).
- **`policies`**: A list of IAM policy ARNs to attach to the group (optional).

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

- Creates an IAM group in AWS.
- Adds users to the group (optional).
- Attaches IAM policies to the group (optional).
- Supports customizing the path for the group.

---

## Explanation of Files

| **File**       | **Description**                                                                                           |
| -------------- | --------------------------------------------------------------------------------------------------------- |
| `main.tf`      | Defines the `aws_iam_group`, `aws_iam_group_membership`, and `aws_iam_group_policy_attachment` resources. |
| `variables.tf` | Declares input variables for configuring the IAM group, users, and policies.                              |
| `outputs.tf`   | Outputs the IAM group name, ID, ARN, and unique ID.                                                       |
| `README.md`    | Documentation for the module.                                                                             |

---

## Inputs

| **Variable** | **Description**                                | **Type**       | **Default** | **Required** |
| ------------ | ---------------------------------------------- | -------------- | ----------- | ------------ |
| `name`       | The name of the IAM group.                     | `string`       | N/A         | Yes          |
| `path`       | The path in which to create the IAM group.     | `string`       | `/`         | No           |
| `users`      | A list of IAM users to add to the group.       | `list(string)` | `[]`        | No           |
| `policies`   | A list of IAM policies to attach to the group. | `list(string)` | `[]`        | No           |

---

## Outputs

| **Output**  | **Description**                                   |
| ----------- | ------------------------------------------------- |
| `name`      | The name of the IAM group.                        |
| `id`        | The ID of the IAM group.                          |
| `arn`       | The ARN assigned by AWS for this IAM group.       |
| `unique_id` | The unique ID assigned by AWS for this IAM group. |

---

## Example Usage

### Basic IAM Group

```hcl
module "iam_group_basic" {
  source = "./iam_group"
  name   = "basic-group"
}
```

### IAM Group with Users and Policies

```hcl
module "iam_group_with_users_and_policies" {
  source   = "./iam_group"
  name     = "admin-group"
  users    = ["user1", "user2"]
  policies = [
    "arn:aws:iam::aws:policy/AdministratorAccess"
  ]
}
```

---

## Authors

This module is maintained by [David Essien](https://davidessien.com).

---

## License

This project is licensed under the MIT License. See `LICENSE` for more information.
