resource "aws_autoscaling_attachment" "this" {
  autoscaling_group_name = var.autoscaling_group_name

  # Conditionally set 'elb' or 'lb_target_group_arn'
  elb = var.elb != null && var.lb_target_group_arn == null ? var.elb : null
  lb_target_group_arn = var.lb_target_group_arn != null && var.elb == null ? var.lb_target_group_arn : null

  lifecycle {
    ignore_changes = [ elb, lb_target_group_arn ]
  }
}
