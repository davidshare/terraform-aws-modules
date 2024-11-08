resource "aws_ebs_volume" "this" {
  availability_zone = var.availability_zone
  size              = var.size
  type              = var.type
  iops              = var.iops
  encrypted         = var.encrypted
  kms_key_id        = var.kms_key_id
  snapshot_id       = var.snapshot_id

  tags = var.tags
}