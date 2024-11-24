### AWS Terraform Module: Secrets Manager Secret Version

This Terraform module is designed to manage versions of AWS Secrets Manager secrets, allowing you to securely store and rotate sensitive data.

---

### **Usage**

#### Example Configuration

```hcl
module "secret_version" {
  source = "./secretsmanager_secret_version"

  secret_id      = "my-secret"
  secret_string  = jsonencode({
    username = "admin"
    password = "P@ssw0rd!"
  })
  version_stages = ["AWSCURRENT"]
}
```

---

### **Features**

- **Secret String/Binary:** Supports storing either text (`secret_string`) or base64-encoded binary data (`secret_binary`).
- **Version Stages:** Manage staging labels for the secret version, like `AWSCURRENT` or custom labels.
- **Automatic Encryption:** Secrets are encrypted using the AWS Secrets Manager default encryption key or a specified KMS key in the secret.

---

### **Requirements**

| **Dependency** | **Version** |
| -------------- | ----------- |
| Terraform      | >= 1.3.0    |
| AWS Provider   | >= 4.0      |

---

### **Providers**

| **Name** | **Source**    |
| -------- | ------------- |
| `aws`    | hashicorp/aws |

---

### **Explanation of Files**

| **File**       | **Description**                                                            |
| -------------- | -------------------------------------------------------------------------- |
| `main.tf`      | Contains the Secrets Manager secret version resource.                      |
| `variables.tf` | Defines all input variables for customizing the secret version.            |
| `outputs.tf`   | Exports key properties of the created secret version for downstream usage. |

---

### **Inputs**

| **Name**         | **Description**                                                                                      | **Type**       | **Default** | **Required** |
| ---------------- | ---------------------------------------------------------------------------------------------------- | -------------- | ----------- | ------------ |
| `secret_id`      | Specifies the secret to which the new version will be added. Accepts ARN or name of the secret.      | `string`       | N/A         | Yes          |
| `secret_string`  | Specifies the text data to encrypt and store. Required if `secret_binary` is not set.                | `string`       | `null`      | No           |
| `secret_binary`  | Specifies binary data (base64-encoded) to encrypt and store. Required if `secret_string` is not set. | `string`       | `null`      | No           |
| `version_stages` | A list of staging labels attached to this version. Defaults to automatically moving `AWSCURRENT`.    | `list(string)` | `[]`        | No           |

---

### **Outputs**

| **Name**                | **Description**                                                              |
| ----------------------- | ---------------------------------------------------------------------------- |
| `id`     | The unique identifier of the secret version.                                 |
| `stages` | The list of staging labels currently attached to this version of the secret. |
| `secret_string`         | The secret value stored in this version (use with caution).                  |

---

### **Example Usages**

#### Storing a Text Secret

```hcl
module "text_secret" {
  source        = "./secretsmanager_secret_version"
  secret_id     = "my-text-secret"
  secret_string = "my-sensitive-data"
}
```

#### Storing a JSON-Encoded Secret

```hcl
module "json_secret" {
  source = "./secretsmanager_secret_version"

  secret_id     = "json-secret"
  secret_string = jsonencode({
    api_key = "123456789"
    region  = "us-west-2"
  })
}
```

#### Storing a Binary Secret

```hcl
module "binary_secret" {
  source = "./secretsmanager_secret_version"

  secret_id     = "binary-secret"
  secret_binary = base64encode("SensitiveBinaryData")
}
```

---

### **Authors**

Maintained by [David Essien](https://davidessien.com).

---

### **License**

This project is licensed under the MIT License.
