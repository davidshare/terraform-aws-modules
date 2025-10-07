resource "aws_route53_zone" "this" {
  name          = var.zone_name
  comment       = var.comment
  force_destroy = var.force_destroy

  dynamic "vpc" {
    for_each = var.vpc_id != null ? [1] : []
    content {
      vpc_id = var.vpc_id
    }
  }

  tags = var.tags
}

resource "aws_route53_record" "this" {
  count   = length(var.records)
  zone_id = aws_route53_zone.this.zone_id
  name    = var.records[count.index].name
  type    = var.records[count.index].type
  ttl     = var.records[count.index].ttl
  records = var.records[count.index].records
}
