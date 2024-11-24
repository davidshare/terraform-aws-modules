### AWS Internet Gateway Terraform Module

**Brief Description**  
The AWS Internet Gateway Terraform Module is designed to create and manage Internet Gateways (IGWs) for a Virtual Private Cloud (VPC) in AWS. It provides an easy way to associate an IGW with a VPC and manage its lifecycle through Terraform. The module also supports tagging to organize and manage resources efficiently.

---

### Usage

To use this module in your Terraform configuration, reference it as shown below:

```hcl
module "internet_gateway" {
  source = "./internet_gateway"

  vpc_id = "vpc-abc12345"
  tags = {
    Name = "MyInternetGateway"
    Environment = "Production"
  }
}
```

**Explanation of Key Parameters**:

- `vpc_id`: The ID of the VPC with which the Internet Gateway will be associated. This is a required parameter.
- `tags`: A map of tags to assign to the Internet Gateway. Tags can help you organize and manage resources. This is optional and defaults to an empty map.

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

- **Create Internet Gateway**: Allows you to create an Internet Gateway and associate it with a specified VPC.
- **Tagging**: You can assign custom tags to the Internet Gateway for easier management and identification.
- **ARN and ID Outputs**: Outputs the ID, ARN, and Owner ID of the created Internet Gateway for further usage or reference in other modules.

---

### Explanation of Files

| **File**       | **Description**                                                         |
| -------------- | ----------------------------------------------------------------------- |
| `main.tf`      | Defines the `aws_internet_gateway` resource and its configuration.      |
| `variables.tf` | Contains input variables like VPC ID and tags for the Internet Gateway. |
| `outputs.tf`   | Defines the output values like Internet Gateway ID, ARN, and Owner ID.  |
| `README.md`    | Documentation for the Internet Gateway Terraform module.                |

---

### Inputs

| **Variable** | **Description**                                           | **Type**      | **Default** | **Required** |
| ------------ | --------------------------------------------------------- | ------------- | ----------- | ------------ |
| `vpc_id`     | The ID of the VPC to associate the Internet Gateway with. | `string`      |             | Yes          |
| `tags`       | A map of tags to assign to the Internet Gateway resource. | `map(string)` | `{}`        | No           |

---

### Outputs

| **Output**                  | **Description**                                           |
| --------------------------- | --------------------------------------------------------- |
| `internet_gateway_id`       | The ID of the created Internet Gateway.                   |
| `internet_gateway_arn`      | The ARN of the created Internet Gateway.                  |
| `internet_gateway_owner_id` | The ID of the AWS account that owns the Internet Gateway. |

---

### Example Usage

#### Basic Internet Gateway Creation

```hcl
module "internet_gateway_basic" {
  source = "./internet_gateway"

  vpc_id = "vpc-abc12345"
}
```

#### Internet Gateway with Tags

```hcl
module "internet_gateway_tagged" {
  source = "./internet_gateway"

  vpc_id = "vpc-xyz67890"
  tags = {
    Name = "MainIGW"
    Environment = "Production"
  }
}
```

---

### Authors

This module is maintained by [David Essien](https://davidessien.com).

---

### License

This module is licensed under the MIT License. See [LICENSE](LICENSE) for more information.
