resource "aws_ecs_task_definition" "this" {
  family                = var.family
  container_definitions = var.container_definitions

  region                   = var.region
  cpu                      = var.cpu
  memory                   = var.memory
  network_mode             = var.network_mode
  ipc_mode                 = var.ipc_mode
  pid_mode                 = var.pid_mode
  execution_role_arn       = var.execution_role_arn
  task_role_arn            = var.task_role_arn
  requires_compatibilities = var.requires_compatibilities
  skip_destroy             = var.skip_destroy
  track_latest             = var.track_latest
  enable_fault_injection   = var.enable_fault_injection
  tags                     = var.tags

  dynamic "runtime_platform" {
    for_each = var.runtime_platform == null ? [] : [var.runtime_platform]
    content {
      operating_system_family = runtime_platform.value.operating_system_family
      cpu_architecture        = runtime_platform.value.cpu_architecture
    }
  }

  dynamic "ephemeral_storage" {
    for_each = var.ephemeral_storage == null ? [] : [var.ephemeral_storage]
    content {
      size_in_gib = ephemeral_storage.value.size_in_gib
    }
  }

  dynamic "proxy_configuration" {
    for_each = var.proxy_configuration == null ? [] : [var.proxy_configuration]
    content {
      type           = proxy_configuration.value.type
      container_name = proxy_configuration.value.container_name
      properties     = proxy_configuration.value.properties
    }
  }

  dynamic "placement_constraints" {
    for_each = var.placement_constraints
    content {
      type       = placement_constraints.value.type
      expression = placement_constraints.value.expression
    }
  }

  dynamic "volume" {
    for_each = var.volumes
    content {
      name                = volume.value.name
      host_path           = volume.value.host_path
      configure_at_launch = volume.value.configure_at_launch

      dynamic "docker_volume_configuration" {
        for_each = volume.value.docker_volume_configuration == null ? [] : [volume.value.docker_volume_configuration]
        content {
          scope         = docker_volume_configuration.value.scope
          autoprovision = docker_volume_configuration.value.autoprovision
          driver        = docker_volume_configuration.value.driver
          driver_opts   = docker_volume_configuration.value.driver_opts
          labels        = docker_volume_configuration.value.labels
        }
      }

      dynamic "efs_volume_configuration" {
        for_each = volume.value.efs_volume_configuration == null ? [] : [volume.value.efs_volume_configuration]
        content {
          file_system_id          = efs_volume_configuration.value.file_system_id
          root_directory          = efs_volume_configuration.value.root_directory
          transit_encryption      = efs_volume_configuration.value.transit_encryption
          transit_encryption_port = efs_volume_configuration.value.transit_encryption_port

          dynamic "authorization_config" {
            for_each = efs_volume_configuration.value.authorization_config == null ? [] : [efs_volume_configuration.value.authorization_config]
            content {
              access_point_id = authorization_config.value.access_point_id
              iam             = authorization_config.value.iam
            }
          }
        }
      }

      dynamic "fsx_windows_file_server_volume_configuration" {
        for_each = volume.value.fsx_windows_file_server_volume_configuration == null ? [] : [volume.value.fsx_windows_file_server_volume_configuration]
        content {
          file_system_id = fsx_windows_file_server_volume_configuration.value.file_system_id
          root_directory = fsx_windows_file_server_volume_configuration.value.root_directory

          authorization_config {
            credentials_parameter = fsx_windows_file_server_volume_configuration.value.authorization_config.credentials_parameter
            domain                = fsx_windows_file_server_volume_configuration.value.authorization_config.domain
          }
        }
      }
    }
  }
}
