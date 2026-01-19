resource "aws_lambda_function" "this" {
  function_name = var.function_name
  handler       = var.handler
  runtime       = var.runtime
  role          = var.role

  filename          = var.filename
  s3_bucket         = var.s3_bucket
  s3_key            = var.s3_key
  s3_object_version = var.s3_object_version
  source_code_hash  = var.source_code_hash

  description                    = var.description
  layers                         = var.layers
  memory_size                    = var.memory_size
  timeout                        = var.timeout
  publish                        = var.publish
  reserved_concurrent_executions = var.reserved_concurrent_executions
  architectures                  = var.architectures
  package_type                   = var.package_type
  image_uri                      = var.image_uri
  image_config {
    entry_point       = each.value.image_config.entry_point
    command           = each.value.image_config.command
    working_directory = each.value.image_config.working_directory
  }
  code_signing_config_arn = var.code_signing_config_arn
  dynamic "dead_letter_config" {

    for_each = var.dead_letter_config.target_arn != null ? toset([1]) : toset([])

    content {
      target_arn = var.dead_letter_config.target_arn
    }
  }

  dynamic "tracing_config" {

    for_each = var.tracing_config.mode != null ? toset([1]) : toset([])

    content {
      mode = var.tracing_config.mode
    }
  }

  dynamic "vpc_config" {
    for_each = var.vpc_config != null ? [var.vpc_config] : []
    content {
      subnet_ids         = vpc_config.value.subnet_ids
      security_group_ids = vpc_config.value.security_group_ids
    }
  }

  dynamic "environment" {
    for_each = var.environment != null ? [var.environment] : []
    content {
      variables = environment.value.variables
    }
  }

  dynamic "file_system_config" {
    for_each = var.file_system_config != null ? [var.file_system_config] : []
    content {
      arn              = file_system_config.value.arn
      local_mount_path = file_system_config.value.local_mount_path
    }
  }

  kms_key_arn = var.kms_key_arn

  tags = var.tags
}