variable "family" {
  description = "Task definition family"
  type        = string
}

variable "container_definitions" {
  description = "JSON document describing container definitions"
  type        = string
}

variable "region" {
  type    = string
  default = null
}

variable "cpu" {
  type    = string
  default = null
}

variable "memory" {
  type    = string
  default = null
}

variable "network_mode" {
  type    = string
  default = null
}

variable "ipc_mode" {
  type    = string
  default = null
}

variable "pid_mode" {
  type    = string
  default = null
}

variable "execution_role_arn" {
  type    = string
  default = null
}

variable "task_role_arn" {
  type    = string
  default = null
}

variable "requires_compatibilities" {
  type    = set(string)
  default = null
}

variable "skip_destroy" {
  type    = bool
  default = false
}

variable "track_latest" {
  type    = bool
  default = false
}

variable "enable_fault_injection" {
  type    = bool
  default = false
}

variable "tags" {
  type    = map(string)
  default = {}
}

variable "runtime_platform" {
  type = object({
    operating_system_family = optional(string)
    cpu_architecture        = optional(string)
  })
  default = null
}

variable "ephemeral_storage" {
  type = object({
    size_in_gib = number
  })
  default = null
}

variable "proxy_configuration" {
  type = object({
    type           = optional(string)
    container_name = string
    properties     = map(string)
  })
  default = null
}

variable "placement_constraints" {
  type = list(object({
    type       = string
    expression = optional(string)
  }))
  default = []
}

variable "volumes" {
  type = list(object({
    name                = string
    host_path           = optional(string)
    configure_at_launch = optional(bool)

    docker_volume_configuration = optional(object({
      scope         = optional(string)
      autoprovision = optional(bool)
      driver        = optional(string)
      driver_opts   = optional(map(string))
      labels        = optional(map(string))
    }))

    efs_volume_configuration = optional(object({
      file_system_id          = string
      root_directory          = optional(string)
      transit_encryption      = optional(string)
      transit_encryption_port = optional(number)

      authorization_config = optional(object({
        access_point_id = optional(string)
        iam             = optional(string)
      }))
    }))

    fsx_windows_file_server_volume_configuration = optional(object({
      file_system_id = string
      root_directory = string
      authorization_config = object({
        credentials_parameter = string
        domain                = string
      })
    }))
  }))
  default = []
}
