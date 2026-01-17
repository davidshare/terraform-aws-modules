# Terraform Module: ECR Repository Policy

This Terraform module creates an **AWS ECR Repository Policy** using a policy document.

---

## **Usage**

### Basic Example

```hcl
module "backend_ecr_policy" {
  source     = "./modules/ecr_repository_policy"
  repository = "backend-app"

  statements = [
    {
      sid    = "AllowBackendAppActions"
      effect = "Allow"
      actions = [
        "ecr:GetDownloadUrlForLayer",
        "ecr:BatchGetImage",
        "ecr:BatchCheckLayerAvailability",
        "ecr:PutImage",
        "ecr:InitiateLayerUpload",
        "ecr:UploadLayerPart",
        "ecr:CompleteLayerUpload",
        "ecr:DescribeRepositories",
        "ecr:GetRepositoryPolicy",
        "ecr:ListImages",
        "ecr:DeleteRepository",
        "ecr:BatchDeleteImage",
        "ecr:SetRepositoryPolicy",
        "ecr:DeleteRepositoryPolicy",
      ]
      principals = [
        {
          type        = "AWS"
          identifiers = ["123456789012"]
        }
      ]
    }
  ]
}
```

---

## **Features**

- Fully customizable IAM policy statements for a single ECR repository.
- Supports multiple principals per statement.
- Generates JSON automatically using `aws_iam_policy_document`.
- Optional `depends_on` argument for handling dependencies.

---

## **Inputs**

| Name         | Description                                        | Type           | Required |
| ------------ | -------------------------------------------------- | -------------- | -------- |
| `repository` | Name of the ECR repository.                        | `string`       | Yes      |
| `statements` | List of policy statements.                         | `list(object)` | Yes      |
| `depends_on` | Optional list of resources this module depends on. | `list(any)`    | No       |

---

## **Outputs**

| Name          | Description                                   |
| ------------- | --------------------------------------------- |
| `repository`  | Name of the repository.                       |
| `policy_json` | JSON representation of the repository policy. |
| `registry_id` | AWS registry ID where the repository exists.  |

---

## **Requirements**

| Name         | Version   |
| ------------ | --------- |
| Terraform    | >= 1.7.5  |
| AWS Provider | >= 5.77.0 |

---

## **Authors**

Maintained by [David Essien](https://davidessien.com).

---

## **License**

MIT License
