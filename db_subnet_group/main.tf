resource "aws_db_subnet_group" "this" {
  name        = var.name
  name_prefix = var.name_prefix
  description = var.description
  subnet_ids  = var.subnet_ids
  tags        = var.tags
}
