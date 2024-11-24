### AWS Terraform Module: SSM Parameter

This module creates an AWS Systems Manager (SSM) Parameter with support for secure encryption, validation patterns, and tagging.

---

### **Usage**

#### Example Configuration

```hcl
module "ssm_parameter" {
  source = "./ssm_parameter"

  name            = "example-parameter"
  description     = "An example SSM parameter"
  type            = "SecureString"
  value           = "MySecureValue"
  key_id          = "arn:aws:kms:us-east-1:123456789012:key/example-key-id"
  allowed_pattern = "^[a-zA-Z0-9]*$"
  tier            = "Advanced"
  tags = {
    Environment = "Production"
    Owner       = "DevOps"
  }
}
```

---

### **Features**

- **Parameter Types**: Supports `String`, `StringList`, and `SecureString`.
- **Encryption**: Option to encrypt `SecureString` values with AWS KMS keys.
- **Validation**: Enforces allowed patterns for parameter values.
- **Tiered Storage**: Choose between `Standard`, `Advanced`, or `Intelligent-Tiering` storage options.
- **Tagging**: Add custom metadata to SSM parameters.

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

### **Explanation of Files**

| **File**       | **Description**                                                   |
| -------------- | ----------------------------------------------------------------- |
| `main.tf`      | Contains the SSM Parameter resource definition.                   |
| `variables.tf` | Defines input variables for configuring the parameter.            |
| `outputs.tf`   | Exports key attributes of the parameter for use in other modules. |

---

### **Inputs**

| **Name**          | **Description**                                                            | **Type**      | **Default**  | **Required** |
| ----------------- | -------------------------------------------------------------------------- | ------------- | ------------ | ------------ |
| `name`            | The name of the parameter.                                                 | `string`      | N/A          | Yes          |
| `description`     | Description of the parameter.                                              | `string`      | `null`       | No           |
| `type`            | The type of the parameter (`String`, `StringList`, `SecureString`).        | `string`      | N/A          | Yes          |
| `value`           | The value of the parameter.                                                | `string`      | N/A          | Yes          |
| `key_id`          | KMS key ARN or ID for encrypting a `SecureString` parameter.               | `string`      | `null`       | No           |
| `allowed_pattern` | A regex pattern to validate the parameter's value.                         | `string`      | `null`       | No           |
| `tier`            | The tier of the parameter (`Standard`, `Advanced`, `Intelligent-Tiering`). | `string`      | `"Standard"` | No           |
| `tags`            | A map of tags to assign to the parameter.                                  | `map(string)` | `{}`         | No           |

---

### **Outputs**

| **Name**  | **Description**                                  |
| --------- | ------------------------------------------------ |
| `name`    | The name of the parameter.                       |
| `arn`     | The Amazon Resource Name (ARN) of the parameter. |
| `version` | The version number of the parameter.             |

---

### **Example Usages**

#### Standard String Parameter

```hcl
module "ssm_string_param" {
  source = "./ssm_parameter"

  name        = "example-string-param"
  type        = "String"
  value       = "ExampleValue"
}
```

#### Secure String Parameter with Encryption

```hcl
module "ssm_secure_param" {
  source = "./ssm_parameter"

  name    = "example-secure-param"
  type    = "SecureString"
  value   = "SensitiveData"
  key_id  = "arn:aws:kms:us-east-1:123456789012:key/example-key-id"
}
```

#### Parameter with Validation Pattern

```hcl
module "ssm_param_with_pattern" {
  source = "./ssm_parameter"

  name            = "example-param-pattern"
  type            = "String"
  value           = "Valid123"
  allowed_pattern = "^[a-zA-Z0-9]*$"
}
```

---

### **Authors**

Maintained by [David Essien](https://davidessien.com).

---

### **License**

This project is licensed under the MIT License.
