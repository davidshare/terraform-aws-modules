# AWS Terraform Module: EKS Cluster

This AWS Terraform module provisions an Amazon EKS (Elastic Kubernetes Service) cluster. The module is designed to simplify the creation and configuration of an EKS cluster, providing flexible options for networking, logging, encryption, and other advanced settings.

---

## Usage

### Example Configuration

```hcl
module "eks_cluster" {
  source                     = "./eks"
  cluster_name               = "example-cluster"
  role_arn                   = "arn:aws:iam::123456789012:role/eks-cluster-role"
  kubernetes_version         = "1.27"
  vpc_config = {
    endpoint_private_access = false
    endpoint_public_access  = true
    public_access_cidrs     = ["0.0.0.0/0"]
    security_group_ids      = []
    subnet_ids              = ["subnet-abc123", "subnet-def456"]
  }
  enabled_cluster_log_types = ["api", "audit", "authenticator"]
  tags = {
    Environment = "Production"
    Owner       = "DevOps Team"
  }
}
```

### Explanation of Key Parameters

- **`cluster_name`**: The name of the EKS cluster.
- **`role_arn`**: IAM role ARN for the Kubernetes control plane to interact with AWS resources.
- **`kubernetes_version`**: Version of Kubernetes to be used for the cluster.
- **`vpc_config`**: Networking configuration, including subnets, security groups, and access settings.
- **`enabled_cluster_log_types`**: Control plane logging types to enable, such as API, audit, or authenticator logs.

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

- Creates an Amazon EKS cluster with configurable Kubernetes and networking options.
- Supports Kubernetes network configurations (e.g., IP family, service CIDR).
- Enables optional control plane logging and encryption.
- Tags all resources for better management.
- Customizable timeouts for cluster operations.

---

## Explanation of Files

| **File**       | **Description**                                                        |
| -------------- | ---------------------------------------------------------------------- |
| `main.tf`      | Defines the primary EKS cluster resource and its configurations.       |
| `variables.tf` | Declares input variables to customize cluster settings.                |
| `outputs.tf`   | Provides outputs such as cluster ID, ARN, and Kubernetes API endpoint. |
| `README.md`    | Documentation for the module.                                          |

---

## Inputs

| **Variable**                | **Description**                                                           | **Type**       | **Default** | **Required** |
| --------------------------- | ------------------------------------------------------------------------- | -------------- | ----------- | ------------ |
| `cluster_name`              | Name of the cluster.                                                      | `string`       | -           | Yes          |
| `role_arn`                  | ARN of the IAM role for the Kubernetes control plane.                     | `string`       | -           | Yes          |
| `vpc_config`                | VPC configuration for the cluster, including subnets and security groups. | `object`       | -           | Yes          |
| `kubernetes_network_config` | Kubernetes network configuration (e.g., service CIDR, IP family).         | `object`       | `{}`        | No           |
| `kubernetes_version`        | Desired Kubernetes master version.                                        | `string`       | `null`      | No           |
| `enabled_cluster_log_types` | List of control plane logging types to enable (e.g., `api`, `audit`).     | `list(string)` | `[]`        | No           |
| `encryption_config`         | Encryption configuration for the cluster.                                 | `list(object)` | `[]`        | No           |
| `tags`                      | A map of tags to apply to all resources.                                  | `map(string)`  | `{}`        | No           |
| `timeouts`                  | Operation timeouts for create, update, and delete actions.                | `object`       | `{}`        | No           |

---

## Outputs

| **Output**                   | **Description**                                                |
| ---------------------------- | -------------------------------------------------------------- |
| `id`                         | The name or ID of the EKS cluster.                             |
| `arn`                        | Amazon Resource Name (ARN) of the EKS cluster.                 |
| `certificate_authority_data` | Base64 encoded certificate for communicating with the cluster. |
| `endpoint`                   | Endpoint for the Kubernetes API server.                        |
| `version`                    | The Kubernetes version of the cluster.                         |
| `platform_version`           | Platform version of the cluster.                               |

---

## Example Usage

### Basic EKS Cluster

```hcl
module "eks_basic" {
  source       = "./eks"
  cluster_name = "basic-cluster"
  role_arn     = "arn:aws:iam::123456789012:role/basic-eks-role"
  vpc_config = {
    subnet_ids = ["subnet-abc123", "subnet-def456"]
  }
}
```

### EKS Cluster with Encryption

```hcl
module "eks_encrypted" {
  source       = "./eks"
  cluster_name = "encrypted-cluster"
  role_arn     = "arn:aws:iam::123456789012:role/eks-encrypted-role"
  vpc_config = {
    subnet_ids = ["subnet-xyz123", "subnet-mno456"]
  }
  encryption_config = [
    {
      provider = {
        key_arn = "arn:aws:kms:region:account-id:key/key-id"
      }
      resources = ["secrets"]
    }
  ]
}
```

---

## Authors

This module is maintained by [David Essien](https://davidessien.com).

---

## License

This project is licensed under the MIT License. See `LICENSE` for more information.
