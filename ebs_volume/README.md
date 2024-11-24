# AWS EBS Volume Terraform Module

This Terraform module manages the creation and configuration of AWS Elastic Block Store (EBS) volumes.

---

## **Usage**

```hcl
module "ebs_volume" {
  source            = "./path-to-module/ebs_volume"
  availability_zone = "us-east-1a"
  size              = 100
  type              = "gp3"
  iops              = 3000
  encrypted         = true
  kms_key_id        = "arn:aws:kms:region:account-id:key/key-id"
  tags = {
    Name        = "example-volume"
    Environment = "Production"
  }
}
```

### Key Parameters in the Example

- **`availability_zone`**: Specifies the AZ where the EBS volume will be created.
- **`size`**: The size of the volume in GiBs.
- **`type`**: The type of EBS volume (e.g., `gp2`, `gp3`, `io1`).
- **`encrypted`**: Enables encryption for the volume.
- **`kms_key_id`**: The ARN of the KMS key for encryption.
- **`tags`**: Tags for resource identification and management.

---

## **Requirements**

| Requirement  | Version  |
| ------------ | -------- |
| Terraform    | >= 1.3.0 |
| AWS Provider | >= 5.0.0 |

---

## **Providers**

| Provider | Source    | Version  |
| -------- | --------- | -------- |
| `aws`    | HashiCorp | >= 5.0.0 |

---

## **Features**

- **Customizable Volume Size and Type**: Create volumes of any supported type and size.
- **Encryption Support**: Optionally encrypt the volume with a specified KMS key.
- **Snapshot Initialization**: Initialize volumes from an existing snapshot.
- **Tagging**: Add metadata to the volume for better management.

---

## **Explanation of Files**

| File           | Description                                                     |
| -------------- | --------------------------------------------------------------- |
| `main.tf`      | Contains the primary resource configuration for the EBS volume. |
| `variables.tf` | Defines input variables for the module.                         |
| `outputs.tf`   | Declares the outputs of the module.                             |
| `README.md`    | Documentation for the module.                                   |

---

## **Inputs**

| Name                | Type          | Default | Required | Description                                             |
| ------------------- | ------------- | ------- | -------- | ------------------------------------------------------- |
| `availability_zone` | `string`      | N/A     | Yes      | The AZ where the EBS volume will be created.            |
| `size`              | `number`      | N/A     | Yes      | The size of the volume in GiBs.                         |
| `type`              | `string`      | `"gp2"` | No       | The type of the EBS volume (`gp2`, `gp3`, `io1`, etc.). |
| `iops`              | `number`      | `null`  | No       | The number of IOPS to provision for the volume.         |
| `encrypted`         | `bool`        | `false` | No       | Whether the volume should be encrypted.                 |
| `kms_key_id`        | `string`      | `null`  | No       | The ARN of the KMS key to use for encryption.           |
| `snapshot_id`       | `string`      | `null`  | No       | The ID of the snapshot to create the volume from.       |
| `tags`              | `map(string)` | `{}`    | No       | Tags to apply to the EBS volume.                        |

---

## **Outputs**

| Name  | Description                      |
| ----- | -------------------------------- |
| `id`  | The unique ID of the EBS volume. |
| `arn` | The ARN of the EBS volume.       |

---

## **Example Usage**

### Example 1: Basic EBS Volume

```hcl
module "basic_ebs_volume" {
  source            = "./path-to-module/ebs_volume"
  availability_zone = "us-west-2a"
  size              = 50
  type              = "gp2"
  tags = {
    Name = "basic-volume"
  }
}
```

### Example 2: Encrypted Volume with Custom KMS Key

```hcl
module "encrypted_ebs_volume" {
  source            = "./path-to-module/ebs_volume"
  availability_zone = "us-east-1b"
  size              = 200
  type              = "io1"
  iops              = 10000
  encrypted         = true
  kms_key_id        = "arn:aws:kms:us-east-1:123456789012:key/my-key-id"
  tags = {
    Name        = "encrypted-volume"
    Environment = "Staging"
  }
}
```

---

## **Authors**

Module maintained by [David Essien](https://davidessien.com).

---

## **License**

This project is licensed under the MIT License.
