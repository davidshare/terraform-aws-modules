### AWS Terraform Module: EKS Node Group

This module provisions an EKS (Elastic Kubernetes Service) Node Group, enabling scalable and managed node groups for your Kubernetes cluster.

---

### Usage

```hcl
module "eks_node_group" {
  source            = "./path/to/eks_node_group"
  cluster_name      = "example-cluster"
  node_group_name   = "example-node-group"
  node_role_arn     = "arn:aws:iam::123456789012:role/eks-node-role"
  subnet_ids        = ["subnet-abc123", "subnet-def456"]

  scaling_config = {
    desired_size = 3
    max_size     = 5
    min_size     = 1
  }

  instance_types = ["t3.medium"]
  capacity_type  = "ON_DEMAND"
  disk_size      = 20

  tags = {
    Environment = "Production"
    Team        = "DevOps"
  }
}
```

---

### Features

- Provisions managed EKS Node Groups with customizable configurations.
- Supports scaling settings for desired, minimum, and maximum nodes.
- Integrates with Launch Templates for advanced configurations.
- Offers flexible support for Kubernetes labels, taints, and update policies.
- Allows remote access settings for node group EC2 instances.
- Supports tagging for resource organization.

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

### Explanation of Files

| File           | Description                                              |
| -------------- | -------------------------------------------------------- |
| `main.tf`      | Defines the EKS Node Group resource and its attributes.  |
| `variables.tf` | Declares input variables for customizing the Node Group. |
| `outputs.tf`   | Exposes outputs such as Node Group ID, ARN, and status.  |

---

### Inputs

| Variable               | Description                                                                          | Type           | Default | Required |
| ---------------------- | ------------------------------------------------------------------------------------ | -------------- | ------- | -------- |
| `cluster_name`         | Name of the EKS cluster.                                                             | `string`       | -       | Yes      |
| `node_group_name`      | Name of the EKS Node Group.                                                          | `string`       | -       | Yes      |
| `node_role_arn`        | ARN of the IAM Role for EKS Node Group.                                              | `string`       | -       | Yes      |
| `subnet_ids`           | Subnet IDs for deploying the Node Group.                                             | `list(string)` | -       | Yes      |
| `scaling_config`       | Desired, minimum, and maximum scaling configuration.                                 | `object`       | -       | Yes      |
| `instance_types`       | List of EC2 instance types for worker nodes.                                         | `list(string)` | `null`  | No       |
| `capacity_type`        | Capacity type for the Node Group (`ON_DEMAND` or `SPOT`).                            | `string`       | `null`  | No       |
| `disk_size`            | Disk size in GiB for each worker node.                                               | `number`       | `null`  | No       |
| `ami_type`             | AMI type for the Node Group (e.g., `AL2_x86_64`, `AL2_ARM_64`).                      | `string`       | `null`  | No       |
| `labels`               | Key-value map of Kubernetes labels to apply to the Node Group.                       | `map(string)`  | `null`  | No       |
| `launch_template`      | Optional Launch Template configuration for custom node settings.                     | `object`       | `null`  | No       |
| `remote_access`        | Configuration for remote access (e.g., SSH key and security group settings).         | `object`       | `null`  | No       |
| `taint`                | Kubernetes taints to apply to the Node Group.                                        | `list(object)` | `null`  | No       |
| `update_config`        | Configuration for update settings, including max unavailable nodes during an update. | `object`       | `null`  | No       |
| `version`              | Kubernetes version to use for the Node Group.                                        | `string`       | `null`  | No       |
| `force_update_version` | Force version update for nodes even if pod disruption budgets are exceeded.          | `bool`         | `null`  | No       |
| `tags`                 | Key-value map of resource tags.                                                      | `map(string)`  | `{}`    | No       |

---

### Outputs

| Output            | Description                                                                 |
| ----------------- | --------------------------------------------------------------------------- |
| `group_id`        | EKS Node Group ID.                                                          |
| `group_arn`       | Amazon Resource Name (ARN) of the Node Group.                               |
| `group_status`    | Status of the Node Group.                                                   |
| `group_resources` | List of objects containing information about underlying resources of nodes. |

---

### Example Scenarios

#### 1. Basic Node Group

```hcl
module "basic_node_group" {
  source         = "./path/to/eks_node_group"
  cluster_name   = "test-cluster"
  node_group_name = "basic-node-group"
  node_role_arn  = "arn:aws:iam::123456789012:role/basic-node-role"
  subnet_ids     = ["subnet-123", "subnet-456"]

  scaling_config = {
    desired_size = 2
    max_size     = 3
    min_size     = 1
  }
}
```

#### 2. Node Group with Launch Template and Labels

```hcl
module "node_group_with_template" {
  source         = "./path/to/eks_node_group"
  cluster_name   = "production-cluster"
  node_group_name = "custom-node-group"
  node_role_arn  = "arn:aws:iam::123456789012:role/eks-role"
  subnet_ids     = ["subnet-123", "subnet-456"]

  scaling_config = {
    desired_size = 5
    max_size     = 10
    min_size     = 3
  }

  instance_types = ["m5.large"]
  labels = {
    environment = "production"
    role        = "backend"
  }

  launch_template = {
    name    = "custom-template"
    version = "1"
  }
}
```

---

### Authors

Module is maintained by [David Essien](https://davidessien.com).

---

### License

This project is licensed under the MIT License. See `LICENSE` for details.
