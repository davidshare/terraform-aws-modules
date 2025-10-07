### AWS IAM Policy Document Terraform Module

This Terraform module is used for generating an IAM policy document in JSON format. It supports creating detailed policy documents with dynamic statements, including conditions and principals. The generated policy document can be used to define permissions for AWS services.

---

### Usage Example

```hcl
module "iam_policy_document" {
  source = "./iam_policy_document"

  statements = [
    {
      sid        = "AllowS3Access"
      actions    = ["s3:ListBucket", "s3:GetObject"]
      effect     = "Allow"
      resources  = ["arn:aws:s3:::my-bucket", "arn:aws:s3:::my-bucket/*"]
      condition_test = "StringEquals"
      condition_variable = "aws:RequestTag/Environment"
      condition_values = ["production"]
      principals = [
        {
          type        = "AWS"
          identifiers = ["arn:aws:iam::123456789012:role/MyRole"]
        }
      ]
    }
  ]

  source_policy_documents = []
  override_policy_documents = []
}
```

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

### Files Overview

- **`main.tf`**: Contains the `aws_iam_policy_document` data source, which dynamically generates the IAM policy document based on input variables.
- **`variables.tf`**: Defines the input variables for the module, including `statements`, `version`, and `source_policy_documents`, among others.
- **`outputs.tf`**: Outputs the generated policy document both in its original and minified JSON format.

---

### Input Variables

| **Variable**                | **Description**                                                                      | **Type**            | **Default**  | **Required** |
| --------------------------- | ------------------------------------------------------------------------------------ | ------------------- | ------------ | ------------ |
| `aws_region`                | The AWS region where the resources will be managed.                                  | `string`            | `us-west-2`  | No           |
| `version`                   | The version of the IAM policy document. Defaults to `2012-10-17`.                    | `string`            | `2012-10-17` | No           |
| `statements`                | List of IAM policy statements to include in the policy document.                     | `list(object(...))` | `[]`         | No           |
| `source_policy_documents`   | List of source IAM policy documents to be merged into the generated policy document. | `list(string)`      | `[]`         | No           |
| `override_policy_documents` | List of override IAM policy documents.                                               | `list(string)`      | `[]`         | No           |

---

### Outputs

| **Output**             | **Description**                                            |
| ---------------------- | ---------------------------------------------------------- |
| `policy_json`          | The generated IAM policy document in JSON format.          |
| `minified_policy_json` | The generated IAM policy document in minified JSON format. |

---

### IAM Policy Document Structure

- **`sid`**: The statement ID (optional).
- **`actions`**: A list of actions that the policy allows or denies.
- **`effect`**: The effect of the statement (`Allow` or `Deny`).
- **`resources`**: A list of resources the actions apply to.
- **`not_actions`, `not_resources`, `not_principals`**: (Optional) Lists of actions, resources, or principals that should be excluded from the statement.
- **`condition`**: (Optional) Defines conditions for the policy statement, including the test type, condition variable, and values.
- **`principals`**: (Optional) Defines the IAM entities (users, roles, etc.) the policy statement applies to.

---

### Example IAM Policy Document Generation

#### Basic Policy Document Example

```hcl
module "iam_policy_document_basic" {
  source = "./iam_policy_document"

  statements = [
    {
      sid       = "AllowS3Access"
      actions   = ["s3:ListBucket", "s3:GetObject"]
      effect    = "Allow"
      resources = ["arn:aws:s3:::my-bucket", "arn:aws:s3:::my-bucket/*"]
    }
  ]
}
```

#### Policy Document with Conditions and Principals

```hcl
module "iam_policy_document_with_conditions" {
  source = "./iam_policy_document"

  statements = [
    {
      sid        = "AllowS3AccessWithCondition"
      actions    = ["s3:ListBucket", "s3:GetObject"]
      effect     = "Allow"
      resources  = ["arn:aws:s3:::my-bucket", "arn:aws:s3:::my-bucket/*"]
      condition_test = "StringEquals"
      condition_variable = "aws:RequestTag/Environment"
      condition_values = ["production"]
      principals = [
        {
          type        = "AWS"
          identifiers = ["arn:aws:iam::123456789012:role/MyRole"]
        }
      ]
    }
  ]
}
```

---

### License

This module is maintained by [David Essien](https://davidessien.com) and is licensed under the MIT License.
