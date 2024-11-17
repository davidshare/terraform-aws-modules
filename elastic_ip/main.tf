resource "aws_eip" "this" {
  domain                    = var.domain
  instance                  = var.instance_id
  network_interface         = var.network_interface
  associate_with_private_ip = var.associate_with_private_ip
  customer_owned_ipv4_pool  = var.customer_owned_ipv4_pool
  ipam_pool_id              = var.ipam_pool_id
  network_border_group      = var.network_border_group
  public_ipv4_pool          = var.public_ipv4_pool
  tags                      = var.tags
}
