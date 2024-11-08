resource "aws_cloudwatch_log_group" "this" {
  name              = var.log_group_name
  retention_in_days = var.retention_in_days
  kms_key_id        = var.kms_key_id

  tags = var.tags
}

resource "aws_cloudwatch_log_metric_filter" "this" {
  count          = length(var.metric_transformation) > 0 ? 1 : 0
  name           = "${var.log_group_name}-metric-filter"
  pattern        = var.metric_filter_pattern
  log_group_name = aws_cloudwatch_log_group.this.name

  dynamic "metric_transformation" {
    for_each = var.metric_transformation
    content {
      name      = metric_transformation.value.name
      namespace = metric_transformation.value.namespace
      value     = metric_transformation.value.value
    }
  }
}

resource "aws_cloudwatch_metric_alarm" "this" {
  count               = var.alarm_name != null ? 1 : 0
  alarm_name          = var.alarm_name
  comparison_operator = var.comparison_operator
  evaluation_periods  = var.evaluation_periods
  metric_name         = var.metric_name
  namespace           = var.namespace
  period              = var.period
  statistic           = var.statistic
  threshold           = var.threshold
  alarm_description   = var.alarm_description
  alarm_actions       = var.alarm_actions

  tags = var.tags
}
