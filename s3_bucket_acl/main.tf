resource "aws_s3_bucket_acl" "this" {
  bucket = var.bucket
  acl    = var.acl

  dynamic "access_control_policy" {
    for_each = var.access_control_policy != null ? [var.access_control_policy] : []
    content {
      dynamic "grant" {
        for_each = access_control_policy.value.grants
        content {
          permission = grant.value.permission

          grantee {
            type          = grant.value.grantee.type
            email_address = try(grant.value.grantee.email_address, null)
            id            = try(grant.value.grantee.id, null)
            uri           = try(grant.value.grantee.uri, null)
          }
        }
      }

      owner {
        id           = access_control_policy.value.owner.id
        display_name = try(access_control_policy.value.owner.display_name, null)
      }
    }
  }

  expected_bucket_owner = var.expected_bucket_owner
}