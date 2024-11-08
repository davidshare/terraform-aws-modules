resource "aws_launch_template" "this" {
  name        = var.name
  description = var.description

  instance_type = var.instance_type
  image_id      = var.image_id
  key_name      = var.key_name

  vpc_security_group_ids = var.vpc_security_group_ids

  user_data = var.user_data

  iam_instance_profile {
    name = var.iam_instance_profile
  }

  dynamic "block_device_mappings" {
    for_each = var.block_device_mappings
    content {
      device_name  = block_device_mappings.value.device_name
      no_device    = block_device_mappings.value.no_device
      virtual_name = block_device_mappings.value.virtual_name

      dynamic "ebs" {
        for_each = block_device_mappings.value.ebs != null ? [block_device_mappings.value.ebs] : []
        content {
          delete_on_termination = ebs.value.delete_on_termination
          encrypted             = ebs.value.encrypted
          iops                  = ebs.value.iops
          kms_key_id            = ebs.value.kms_key_id
          snapshot_id           = ebs.value.snapshot_id
          volume_size           = ebs.value.volume_size
          volume_type           = ebs.value.volume_type
        }
      }
    }
  }

  dynamic "network_interfaces" {
    for_each = var.network_interfaces
    content {
      associate_public_ip_address = network_interfaces.value.associate_public_ip_address
      delete_on_termination       = network_interfaces.value.delete_on_termination
      description                 = network_interfaces.value.description
      device_index                = network_interfaces.value.device_index
      ipv6_addresses              = network_interfaces.value.ipv6_addresses
      ipv6_address_count          = network_interfaces.value.ipv6_address_count
      network_interface_id        = network_interfaces.value.network_interface_id
      private_ip_address          = network_interfaces.value.private_ip_address
      subnet_id                   = network_interfaces.value.subnet_id
    }
  }

  tags = var.tags
}
