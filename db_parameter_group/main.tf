resource "aws_db_parameter_group" "this" {
  name         = var.name
  name_prefix  = var.name_prefix
  family       = var.family
  description  = var.description
  skip_destroy = var.skip_destroy

  tags = var.tags

  dynamic "parameter" {
    for_each = var.parameters
    content {
      name         = parameter.value.name
      value        = parameter.value.value
      apply_method = parameter.value.apply_method
    }
  }

  lifecycle {
    create_before_destroy = true
  }
}
