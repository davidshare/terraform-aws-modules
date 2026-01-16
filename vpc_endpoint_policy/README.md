# Terraform Module: AWS VPC Endpoint Policy

A robust and safe Terraform module for managing `aws_vpc_endpoint_policy`.

This resource controls access to AWS services via VPC Endpoints (e.g., S3, DynamoDB, ECR) using custom IAM policies.

## Features

- Full support for custom JSON policies
- Optional strict validation of policy structure
- Clear outputs including effective policy
- Safe handling of `null` policy (AWS applies full access default)
- Sensitive marking on policy outputs

## Requirements

- Terraform >= 1.0
- AWS Provider >= 5.0

## Usage Examples

### Full Access (Default - Recommended to omit policy)

```hcl
module "s3_endpoint_policy" {
  source = "./modules/vpc-endpoint-policy"

  vpc_endpoint_id = module.s3_endpoint.id
  # policy omitted → AWS applies full access
}
```

### Least Privilege (Recommended for Production)

```hcl
module "ecr_endpoint_policy" {
  source = "./modules/vpc-endpoint-policy"

  vpc_endpoint_id = module.ecr_dkr_endpoint.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = "*"
        Action = [
          "ecr:BatchGetImage",
          "ecr:GetDownloadUrlForLayer",
          "ecr:BatchCheckLayerAvailability"
        ]
        Resource = "*"
      }
    ]
  })
}
```

### Deny Access to Specific Actions

```hcl
module "dynamodb_endpoint_policy" {
  source = "./modules/vpc-endpoint-policy"

  vpc_endpoint_id = module.dynamodb_endpoint.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect    = "Allow"
        Principal = "*"
        Action    = "dynamodb:*"
        Resource  = "*"
      },
      {
        Effect    = "Deny"
        Principal = "*"
        Action    = ["dynamodb:DeleteTable", "dynamodb:CreateTable"]
        Resource  = "*"
      }
    ]
  })
}
```

## Important Notes

- Not all VPC Endpoints support policies (e.g., some newer Interface endpoints do not).
- Gateway endpoints (S3, DynamoDB) and many Interface endpoints support policies.
- If `policy` is not set, AWS applies **full access** — acceptable for trusted VPCs, but use least privilege in production.
- The `aws_vpc_endpoint_policy` resource **does not support tags**.

## Inputs & Outputs

See `variables.tf` and `outputs.tf` for full details.

## Integration Tip

Use this module alongside the `vpc-endpoint` module:

```hcl
module "s3_endpoint" {
  source = "../vpc-endpoint"
  # ... config
}

module "s3_endpoint_policy" {
  source          = "../vpc-endpoint-policy"
  vpc_endpoint_id = module.s3_endpoint.id
  policy          = data.aws_iam_policy_document.s3_endpoint.json
}
```

This ensures explicit, secure, and auditable access control.
