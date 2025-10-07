# AWS Lambda Function Terraform Module

This module creates an AWS Lambda function using Terraform. It supports configuration for VPC access, environment variables, and optional integrations with KMS encryption and Lambda Layers. The module is designed to simplify the creation and management of AWS Lambda functions in a Terraform configuration.

---

## Usage

Below is an example of how to use this module in your Terraform configuration:

```hcl
module "lambda_function" {
  source          = "./path-to-lambda-module"
  function_name   = "my-lambda-function"
  handler         = "index.handler"
  runtime         = "nodejs14.x"
  role            = aws_iam_role.lambda_role.arn
  filename        = "path/to/lambda.zip"
  memory_size     = 256
  timeout         = 10
  environment     = {
    variables = {
      ENV_VAR = "value"
    }
  }
  tags = {
    Environment = "Production"
    Application = "MyApp"
  }
}
```

### Key Parameters

- **`function_name`**: Unique name for the Lambda function.
- **`handler`**: Entry point for the Lambda function.
- **`runtime`**: Runtime environment (e.g., `nodejs14.x`, `python3.9`).
- **`role`**: IAM role ARN with necessary permissions.
- **`environment`**: Configuration for environment variables.
- **`tags`**: Tags for the Lambda function to support resource management.

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

- Creation of AWS Lambda functions.
- Support for VPC configuration and secure access.
- Integration with AWS KMS for encryption of environment variables.
- Support for up to 5 Lambda Layers.
- Custom tagging for resource identification and management.

---

## Explanation of Files

| File           | Description                                                                |
| -------------- | -------------------------------------------------------------------------- |
| `main.tf`      | Contains the primary resource definitions for the Lambda function.         |
| `variables.tf` | Defines input variables and their default values for module customization. |
| `outputs.tf`   | Specifies outputs for the module, such as the Lambda ARN and name.         |
| `README.md`    | Provides documentation for the module, including usage and configuration.  |

---

## Inputs

| Name                | Type           | Default | Description                                                                     | Required |
| ------------------- | -------------- | ------- | ------------------------------------------------------------------------------- | -------- |
| `function_name`     | `string`       | N/A     | A unique name for your Lambda Function.                                         | Yes      |
| `handler`           | `string`       | N/A     | The function entry point in your code.                                          | Yes      |
| `runtime`           | `string`       | N/A     | The runtime environment for the Lambda function you are uploading.              | Yes      |
| `role`              | `string`       | N/A     | IAM role attached to the Lambda Function.                                       | Yes      |
| `filename`          | `string`       | `null`  | Path to the function's deployment package within the local filesystem.          | No       |
| `s3_bucket`         | `string`       | `null`  | S3 bucket location containing the function's deployment package.                | No       |
| `s3_key`            | `string`       | `null`  | S3 key of an object containing the function's deployment package.               | No       |
| `s3_object_version` | `string`       | `null`  | Object version containing the function's deployment package.                    | No       |
| `source_code_hash`  | `string`       | `null`  | Used to trigger updates when file contents change.                              | No       |
| `description`       | `string`       | `null`  | Description of what your Lambda Function does.                                  | No       |
| `layers`            | `list(string)` | `null`  | List of Lambda Layer Version ARNs to attach to the Lambda Function.             | No       |
| `memory_size`       | `number`       | `128`   | Amount of memory (in MB) your Lambda Function can use at runtime.               | No       |
| `timeout`           | `number`       | `3`     | Timeout (in seconds) for the Lambda function.                                   | No       |
| `vpc_config`        | `object`       | `null`  | VPC configuration including subnet IDs and security group IDs.                  | No       |
| `environment`       | `object`       | `null`  | Environment variables configuration settings.                                   | No       |
| `kms_key_arn`       | `string`       | `null`  | ARN of the KMS key used to encrypt the Lambda function's environment variables. | No       |
| `tags`              | `map(string)`  | `{}`    | Mapping of tags to assign to the Lambda function.                               | No       |

---

## Outputs

| Name         | Description                                      |
| ------------ | ------------------------------------------------ |
| `arn`        | The ARN of the Lambda Function.                  |
| `invoke_arn` | The Invoke ARN of the Lambda Function.           |
| `name`       | The name of the Lambda Function.                 |
| `version`    | Latest published version of the Lambda Function. |

---

## Example Usage

### Basic Example

```hcl
module "lambda_function" {
  source          = "./path-to-lambda-module"
  function_name   = "example-lambda"
  handler         = "main.handler"
  runtime         = "python3.9"
  role            = aws_iam_role.lambda_role.arn
  filename        = "example.zip"
}
```

### Advanced Example with VPC and Environment Variables

```hcl
module "lambda_function" {
  source          = "./path-to-lambda-module"
  function_name   = "vpc-enabled-lambda"
  handler         = "index.handler"
  runtime         = "nodejs14.x"
  role            = aws_iam_role.lambda_role.arn
  vpc_config      = {
    subnet_ids         = ["subnet-0123456789abcdef"]
    security_group_ids = ["sg-0123456789abcdef"]
  }
  environment     = {
    variables = {
      LOG_LEVEL = "DEBUG"
    }
  }
}
```

---

## Authors

Maintained by [David Essien](https://davidessien.com).

---

## License

This project is licensed under the MIT License.
