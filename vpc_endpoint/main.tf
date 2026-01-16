locals {
  # Determine endpoint identifier for naming
  endpoint_identifier = (
    var.service_name != null
    ? element(split(".", var.service_name), length(split(".", var.service_name)) - 1)
    : var.resource_configuration_arn != null
    ? "lattice-resource"
    : var.service_network_arn != null
    ? "lattice-service-network"
    : lower(var.vpc_endpoint_type)
  )

  tags = merge(
    {
      Name      = "vpce-${local.endpoint_identifier}"
      ManagedBy = "Terraform"
    },
    var.tags
  )
}

resource "aws_vpc_endpoint" "this" {
  vpc_id = var.vpc_id

  # Exactly one service reference
  service_name               = var.service_name
  resource_configuration_arn = var.resource_configuration_arn
  service_network_arn        = var.service_network_arn

  # Core configuration
  vpc_endpoint_type   = var.vpc_endpoint_type
  auto_accept         = var.auto_accept
  policy              = var.policy
  private_dns_enabled = var.private_dns_enabled
  ip_address_type     = var.ip_address_type
  service_region      = var.service_region

  # Associations - conditionally applied to avoid invalid configs
  route_table_ids    = var.vpc_endpoint_type == "Gateway" ? var.route_table_ids : null
  subnet_ids         = contains(["Interface", "GatewayLoadBalancer", "Resource", "ServiceNetwork"], var.vpc_endpoint_type) ? var.subnet_ids : null
  security_group_ids = var.vpc_endpoint_type == "Interface" ? var.security_group_ids : null

  # DNS options block
  dynamic "dns_options" {
    for_each = var.dns_options != null ? [var.dns_options] : []
    content {
      dns_record_ip_type                             = dns_options.value.dns_record_ip_type
      private_dns_only_for_inbound_resolver_endpoint = dns_options.value.private_dns_only_for_inbound_resolver_endpoint
    }
  }

  # Custom IP per subnet
  dynamic "subnet_configuration" {
    for_each = var.subnet_configuration
    content {
      subnet_id = subnet_configuration.value.subnet_id
      ipv4      = subnet_configuration.value.ipv4
      ipv6      = subnet_configuration.value.ipv6
    }
  }

  tags = local.tags

  timeouts {
    create = var.create_timeout
    update = var.update_timeout
    delete = var.delete_timeout
  }

  lifecycle {
    # Exactly one service reference required
    precondition {
      condition = (
        (var.service_name != null ? 1 : 0) +
        (var.resource_configuration_arn != null ? 1 : 0) +
        (var.service_network_arn != null ? 1 : 0)
      ) == 1
      error_message = "Exactly one of 'service_name', 'resource_configuration_arn', or 'service_network_arn' must be provided."
    }

    # Subnet requirements
    precondition {
      condition     = !contains(["Interface", "GatewayLoadBalancer", "Resource", "ServiceNetwork"], var.vpc_endpoint_type) || length(var.subnet_ids) > 0
      error_message = "Endpoints of type Interface, GatewayLoadBalancer, Resource, or ServiceNetwork require at least one subnet in 'subnet_ids'."
    }

    # Security groups only for Interface
    precondition {
      condition     = var.vpc_endpoint_type != "Interface" || var.security_group_ids != null
      error_message = "Interface endpoints require 'security_group_ids' to be set (can be an empty list [] to use the VPC's default security group)."
    }

    # Route tables only for Gateway
    precondition {
      condition     = var.vpc_endpoint_type != "Gateway" || var.route_table_ids != null
      error_message = "Gateway endpoints require 'route_table_ids' to be set."
    }

    # Private DNS only meaningful for Interface (AWS services)
    precondition {
      condition     = var.private_dns_enabled == null || var.vpc_endpoint_type == "Interface"
      error_message = "'private_dns_enabled' can only be set for Interface endpoints."
    }

    # dns_options only for Interface
    precondition {
      condition     = var.dns_options == null || var.vpc_endpoint_type == "Interface"
      error_message = "'dns_options' block is only valid for Interface endpoints."
    }

    # ip_address_type restrictions
    precondition {
      condition     = var.ip_address_type == null || contains(["ipv4", "dualstack", "ipv6"], var.ip_address_type)
      error_message = "Valid values for 'ip_address_type' are 'ipv4', 'dualstack', or 'ipv6'."
    }
  }
}