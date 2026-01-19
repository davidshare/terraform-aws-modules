resource "aws_ecs_cluster" "this" {
  name   = var.name
  region = var.region
  tags   = var.tags

  dynamic "setting" {
    for_each = var.settings
    content {
      name  = setting.value.name
      value = setting.value.value
    }
  }

  dynamic "service_connect_defaults" {
    for_each = var.service_connect_defaults == null ? [] : [var.service_connect_defaults]
    content {
      namespace = service_connect_defaults.value.namespace
    }
  }

  dynamic "configuration" {
    for_each = var.configuration == null ? [] : [var.configuration]
    content {

      dynamic "execute_command_configuration" {
        for_each = configuration.value.execute_command_configuration == null ? [] : [configuration.value.execute_command_configuration]
        content {
          kms_key_id = execute_command_configuration.value.kms_key_id
          logging    = execute_command_configuration.value.logging

          dynamic "log_configuration" {
            for_each = execute_command_configuration.value.log_configuration == null ? [] : [execute_command_configuration.value.log_configuration]
            content {
              cloud_watch_encryption_enabled = log_configuration.value.cloud_watch_encryption_enabled
              cloud_watch_log_group_name     = log_configuration.value.cloud_watch_log_group_name
              s3_bucket_name                 = log_configuration.value.s3_bucket_name
              s3_bucket_encryption_enabled   = log_configuration.value.s3_bucket_encryption_enabled
              s3_key_prefix                  = log_configuration.value.s3_key_prefix
            }
          }
        }
      }

      dynamic "managed_storage_configuration" {
        for_each = configuration.value.managed_storage_configuration == null ? [] : [configuration.value.managed_storage_configuration]
        content {
          fargate_ephemeral_storage_kms_key_id = managed_storage_configuration.value.fargate_ephemeral_storage_kms_key_id
          kms_key_id                           = managed_storage_configuration.value.kms_key_id
        }
      }
    }
  }
}
