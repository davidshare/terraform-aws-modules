resource "aws_vpc_endpoint_route_table_association" "this" {
  vpc_endpoint_id = var.vpc_endpoint_id
  route_table_id  = var.route_table_id
}