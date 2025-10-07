resource "aws_subnet" "this" {
  vpc_id                                         = var.vpc_id
  cidr_block                                     = var.cidr_block
  availability_zone                              = var.availability_zone
  availability_zone_id                           = var.availability_zone_id
  enable_dns64                                   = var.enable_dns64
  enable_resource_name_dns_aaaa_record_on_launch = var.enable_resource_name_dns_aaaa_record_on_launch
  enable_resource_name_dns_a_record_on_launch    = var.enable_resource_name_dns_a_record_on_launch
  ipv6_cidr_block                                = var.ipv6_cidr_block
  ipv6_native                                    = var.ipv6_native
  map_public_ip_on_launch                        = var.map_public_ip_on_launch
  private_dns_hostname_type_on_launch            = var.private_dns_hostname_type_on_launch

  # Conditionally set map_customer_owned_ip_on_launch
  map_customer_owned_ip_on_launch = var.map_customer_owned_ip_on_launch ? var.map_customer_owned_ip_on_launch : null

  # Conditionally set customer_owned_ipv4_pool
  customer_owned_ipv4_pool = var.customer_owned_ipv4_pool != null && var.map_customer_owned_ip_on_launch ? var.customer_owned_ipv4_pool : null

  # Conditionally set outpost_arn
  outpost_arn = var.outpost_arn != null && var.map_customer_owned_ip_on_launch ? var.outpost_arn : null

  tags = var.tags
}
