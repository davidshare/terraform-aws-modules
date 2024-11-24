### AWS Terraform Module: Secrets Manager Secret

This module provisions AWS Secrets Manager secrets, providing secure storage and replication across regions for sensitive data.

---

### **Usage**

#### Example Configuration

```hcl
module "secrets_manager_secret" {
  source = "./secretsmanager_secret"

  name        = "my-secret"
  description = "API key for external service"
  kms_key_id  = "arn:aws:kms:us-west-2:123456789012:key/abcd-1234-efgh-5678"

  replica = [
    {
      region     = "us-east-1"
      kms_key_id = "arn:aws:kms:us-east-1:123456789012:key/ijkl-9101-mnop-1121"
    }
  ]

  tags = {
    Environment = "Production"
    Service     = "SecretsManager"
  }
}
```

---

### **Features**

- **Secret Storage**: Supports creation and management of secrets with optional encryption using a specified KMS key.
- **Replication**: Allows secret replication across multiple AWS regions for high availability.
- **Flexible Naming**: Option to specify a friendly name or a name prefix for unique secret creation.
- **Custom Policies**: Supports attaching a custom resource policy to the secret.
- **Tagging**: Enables tagging for better resource organization.

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

| **File**       | **Description**                                                    |
| -------------- | ------------------------------------------------------------------ |
| `main.tf`      | Contains the Secrets Manager secret resource configuration.        |
| `variables.tf` | Defines all input variables for configuring the secret.            |
| `outputs.tf`   | Exports key attributes of the created secret for downstream usage. |

---

### **Inputs**

| **Name**                         | **Description**                                                       | **Type**              | **Default** | **Required** |
| -------------------------------- | --------------------------------------------------------------------- | --------------------- | ----------- | ------------ |
| `description`                    | A description of the secret.                                          | `string`              | `null`      | No           |
| `kms_key_id`                     | ARN or ID of the KMS key used to encrypt the secret.                  | `string`              | `null`      | No           |
| `name`                           | Friendly name of the secret. Conflicts with `name_prefix`.            | `string`              | `null`      | No           |
| `name_prefix`                    | Prefix for generating a unique secret name. Conflicts with `name`.    | `string`              | `null`      | No           |
| `policy`                         | JSON policy to attach to the secret.                                  | `string`              | `null`      | No           |
| `recovery_window_in_days`        | Number of days AWS waits before deleting the secret. Default is 30.   | `number`              | `30`        | No           |
| `force_overwrite_replica_secret` | Whether to overwrite a secret with the same name in a replica region. | `bool`                | `false`     | No           |
| `tags`                           | Key-value map of user-defined tags attached to the secret.            | `map(string)`         | `{}`        | No           |
| `replica`                        | List of replica configurations.                                       | `list(object({...}))` | `[]`        | No           |

---

### **Outputs**

| **Name**   | **Description**                                                               |
| ---------- | ----------------------------------------------------------------------------- |
| `id`       | The ID of the created secret.                                                 |
| `arn`      | The ARN of the created secret.                                                |
| `replica`  | Attributes of replicas, including status and last accessed date.              |
| `tags_all` | All tags assigned to the resource, including inherited provider default tags. |

---

### **Example Usages**

#### Basic Secret

```hcl
module "basic_secret" {
  source = "./secretsmanager_secret"

  name        = "basic-secret"
  description = "A basic secret without replication"
}
```

#### Replicated Secret

```hcl
module "replicated_secret" {
  source = "./secretsmanager_secret"

  name = "replicated-secret"

  replica = [
    { region = "us-east-1" },
    { region = "eu-west-1" }
  ]
}
```

---

### **Authors**

Maintained by [David Essien](https://davidessien.com).

---

### **License**

This project is licensed under the MIT License.
