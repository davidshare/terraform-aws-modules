resource "aws_vpc_endpoint_subnet_association" "this" {
  vpc_endpoint_id = var.vpc_endpoint_id
  subnet_id       = var.subnet_id

  timeouts {
    create = var.create_timeout
    delete = var.delete_timeout
  }

  lifecycle {
    precondition {
      condition = (
        var.vpc_endpoint_id != null &&
        length(trimspace(var.vpc_endpoint_id)) > 0 &&
        var.subnet_id != null &&
        length(trimspace(var.subnet_id)) > 0
      )
      error_message = "Both 'vpc_endpoint_id' and 'subnet_id' must be non-empty strings."
    }
  }
}