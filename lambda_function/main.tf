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

  description = var.description
  layers      = var.layers
  memory_size = var.memory_size
  timeout     = var.timeout

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

  kms_key_arn = var.kms_key_arn

  tags = var.tags
}
