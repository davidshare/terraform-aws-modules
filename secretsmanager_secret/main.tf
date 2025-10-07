resource "aws_secretsmanager_secret" "this" {
  description                    = var.description
  kms_key_id                     = var.kms_key_id
  name                           = var.name
  name_prefix                    = var.name_prefix
  policy                         = var.policy
  recovery_window_in_days        = var.recovery_window_in_days
  force_overwrite_replica_secret = var.force_overwrite_replica_secret
  tags                           = var.tags

  dynamic "replica" {
    for_each = var.replica
    content {
      kms_key_id = lookup(replica.value, "kms_key_id", null)
      region     = replica.value.region
    }
  }
}
