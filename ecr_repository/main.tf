resource "aws_ecr_repository" "this" {
  name                 = var.name
  force_delete         = var.force_delete
  image_tag_mutability = var.image_tag_mutability
  tags                 = var.tags

  dynamic "image_tag_mutability_exclusion_filter" {
    for_each = var.image_tag_mutability_exclusion_filters
    content {
      filter      = image_tag_mutability_exclusion_filter.value.filter
      filter_type = image_tag_mutability_exclusion_filter.value.filter_type
    }
  }

  image_scanning_configuration {
    scan_on_push = var.image_scanning_configuration.scan_on_push
  }

  encryption_configuration {
    encryption_type = var.encryption_configuration.encryption_type
    kms_key         = var.encryption_configuration.kms_key
  }
}
