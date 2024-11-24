AWS Terraform Module: Elastic Beanstalk Application

## Brief Description

This AWS Terraform module provisions and manages an Elastic Beanstalk application. It allows you to define and manage an application name, description, and associated version lifecycle configurations. Additionally, it supports tagging resources for organization and management purposes.

---

## Usage

### Example Configuration

```hcl
module "elastic_beanstalk_application" {
  source        = "./elastic_beanstalk_application"
  name          = "my-app"
  description   = "My awesome web application"
  tags = {
    Environment = "Production"
    Owner       = "DevOps Team"
  }
}
```

### Explanation of Key Parameters

- **`name`**: The name of the Elastic Beanstalk application.
- **`description`**: A short description of the application (optional).
- **`appversion_lifecycle`**: A configuration block for application version lifecycle management, including the service role, maximum count, source deletion from S3, and maximum age of the application versions.
- **`tags`**: A map of tags to apply to the Elastic Beanstalk application resource for organization.

---

## Requirements

| **Requirement** | **Version** |
| --------------- | ----------- |
| Terraform       | >= 1.0.0    |
| AWS Provider    | >= 4.0      |

---

## Providers

| **Provider** | **Purpose**            |
| ------------ | ---------------------- |
| `aws`        | Manages AWS resources. |

---

## Features

- Creates an Elastic Beanstalk application with name and description.
- Configures application version lifecycle, including setting roles, max version count, and age limitations.
- Supports tagging resources for better resource management and cost tracking.

---

## Explanation of Files

| **File**       | **Description**                                                                                    |
| -------------- | -------------------------------------------------------------------------------------------------- |
| `main.tf`      | Defines the `aws_elastic_beanstalk_application` resource and configures the application lifecycle. |
| `variables.tf` | Declares input variables for configuring the application and version lifecycle.                    |
| `outputs.tf`   | Outputs the Elastic Beanstalk application's name and ARN.                                          |
| `README.md`    | Documentation for the module.                                                                      |

---

## Inputs

| **Variable**           | **Description**                                                        | **Type**      | **Default** | **Required** |
| ---------------------- | ---------------------------------------------------------------------- | ------------- | ----------- | ------------ |
| `name`                 | The name of the Elastic Beanstalk application.                         | `string`      | N/A         | Yes          |
| `description`          | Short description of the application.                                  | `string`      | `null`      | No           |
| `appversion_lifecycle` | Configuration for application version lifecycle management.            | `object`      | `null`      | No           |
| `tags`                 | A map of tags to assign to the Elastic Beanstalk application resource. | `map(string)` | `{}`        | No           |

---

## Outputs

| **Output** | **Description**                                |
| ---------- | ---------------------------------------------- |
| `name`     | The name of the Elastic Beanstalk application. |
| `arn`      | The ARN of the Elastic Beanstalk application.  |

---

## Example Usage

### Basic Elastic Beanstalk Application

```hcl
module "elastic_beanstalk_basic" {
  source        = "./elastic_beanstalk_application"
  name          = "my-app"
  description   = "Basic web application"
  tags = {
    Environment = "Staging"
    Owner       = "DevOps Team"
  }
}
```

### Elastic Beanstalk Application with Version Lifecycle

```hcl
module "elastic_beanstalk_with_lifecycle" {
  source        = "./elastic_beanstalk_application"
  name          = "my-app-with-lifecycle"
  description   = "Web application with version lifecycle management"
  appversion_lifecycle = {
    service_role          = "arn:aws:iam::123456789012:role/my-service-role"
    max_count             = 5
    delete_source_from_s3 = true
    max_age_in_days       = 30
  }
  tags = {
    Environment = "Production"
    Owner       = "DevOps Team"
  }
}
```

---

## Authors

This module is maintained by [David Essien](https://davidessien.com).

---

## License

This project is licensed under the MIT License. See `LICENSE` for more information.
