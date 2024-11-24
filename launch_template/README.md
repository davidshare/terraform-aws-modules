# AWS Launch Template Terraform Module

This Terraform module manages the creation of AWS Launch Templates. It simplifies and standardizes the configuration of EC2 launch templates with a variety of customizable options for instances.

## Usage

```hcl
module "launch_template" {
  source  = "./launch_template"

  name         = "example-launch-template"
  image_id     = "ami-1234567890abcdef"
  instance_type = "t2.micro"
  tags = {
    Environment = "Development"
    Team        = "DevOps"
  }
}
```

### Explanation of Key Parameters

- **name**: The name of the launch template.
- **image_id**: The AMI ID for launching instances.
- **instance_type**: The type of EC2 instance to launch.
- **tags**: A map of tags to assign to the launch template.

---

## Requirements

| Requirement  | Version |
| ------------ | ------- |
| Terraform    | >= 1.0  |
| AWS Provider | >= 4.0  |

---

## Providers

| Name | Version |
| ---- | ------- |
| aws  | >= 4.0  |

---

## Features

- Simplifies EC2 instance configurations.
- Supports advanced instance customization (e.g., CPU options, network interfaces).
- Handles tags and security group associations.
- Enables EBS optimization, spot instances, and other instance features.

---

## Explanation of Files

| File           | Description                                                                                |
| -------------- | ------------------------------------------------------------------------------------------ |
| `main.tf`      | Core module logic to define the AWS Launch Template resource.                              |
| `variables.tf` | Input variables defining the parameters for the launch template configuration.             |
| `outputs.tf`   | Outputs from the module, such as the launch template ID and ARN.                           |
| `README.md`    | Documentation for using the module, including inputs, outputs, and example configurations. |

---

## Inputs

| Variable                 | Type          | Default | Description                                                |
| ------------------------ | ------------- | ------- | ---------------------------------------------------------- |
| `name`                   | `string`      | `null`  | The name of the launch template.                           |
| `name_prefix`            | `string`      | `null`  | Creates a unique name beginning with the specified prefix. |
| `description`            | `string`      | `null`  | Description of the launch template.                        |
| `default_version`        | `number`      | `null`  | Default version of the launch template.                    |
| `update_default_version` | `bool`        | `null`  | Whether to update default version on each update.          |
| `ebs_optimized`          | `bool`        | `null`  | If true, the EC2 instance will be EBS-optimized.           |
| `image_id`               | `string`      | `null`  | The AMI ID for the EC2 instance.                           |
| `instance_type`          | `string`      | `null`  | The type of EC2 instance.                                  |
| `tags`                   | `map(string)` | `{}`    | A map of tags to assign to the launch template.            |
| ...                      | ...           | ...     | ...                                                        |

---

## Outputs

| Output           | Description                                                                        |
| ---------------- | ---------------------------------------------------------------------------------- |
| `id`             | The ID of the launch template.                                                     |
| `arn`            | Amazon Resource Name (ARN) of the launch template.                                 |
| `latest_version` | The latest version of the launch template.                                         |
| `tags_all`       | A map of tags assigned to the resource, including inherited provider default tags. |

---

## Example Usage

### Basic Launch Template

```hcl
module "launch_template" {
  source  = "./launch_template"

  name            = "basic-template"
  image_id        = "ami-0abcdef1234567890"
  instance_type   = "t2.micro"
  ebs_optimized   = true
  tags = {
    Name        = "BasicTemplate"
    Environment = "Production"
  }
}
```

### Advanced Configuration

```hcl
module "launch_template" {
  source  = "./launch_template"

  name              = "advanced-template"
  instance_type     = "t3.large"
  image_id          = "ami-0abcdef1234567890"
  cpu_options       = { core_count = 2, threads_per_core = 1 }
  metadata_options  = { http_tokens = "required", http_endpoint = "enabled" }
  tags = {
    Project     = "Advanced"
    Department  = "Tech"
  }
}
```

---

## Authors

This module is maintained by [David Essien](https://davidessien.com).

---

## License

This project is licensed under the Apache License 2.0. See the LICENSE file for details.
