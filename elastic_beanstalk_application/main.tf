resource "aws_elastic_beanstalk_application" "this" {
  name        = var.name
  description = var.description

  dynamic "appversion_lifecycle" {
    for_each = var.appversion_lifecycle != null ? [var.appversion_lifecycle] : []
    content {
      service_role          = appversion_lifecycle.value.service_role
      max_count             = appversion_lifecycle.value.max_count
      delete_source_from_s3 = appversion_lifecycle.value.delete_source_from_s3
      max_age_in_days       = appversion_lifecycle.value.max_age_in_days
    }
  }

  tags = var.tags
}