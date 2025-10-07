resource "aws_cloudwatch_metric_alarm" "this" {
  alarm_name                            = var.alarm_name
  comparison_operator                   = var.comparison_operator
  evaluation_periods                    = var.evaluation_periods
  metric_name                           = var.metric_name
  namespace                             = var.namespace
  period                                = var.period
  statistic                             = var.statistic
  threshold                             = var.threshold
  threshold_metric_id                   = var.threshold_metric_id
  alarm_description                     = var.alarm_description
  insufficient_data_actions             = var.insufficient_data_actions
  actions_enabled                       = var.actions_enabled
  alarm_actions                         = var.alarm_actions
  ok_actions                            = var.ok_actions
  datapoints_to_alarm                   = var.datapoints_to_alarm
  dimensions                            = var.dimensions
  unit                                  = var.unit
  extended_statistic                    = var.extended_statistic
  treat_missing_data                    = var.treat_missing_data
  evaluate_low_sample_count_percentiles = var.evaluate_low_sample_count_percentiles

  dynamic "metric_query" {
    for_each = var.metric_query
    content {
      id          = metric_query.value.id
      expression  = metric_query.value.expression
      label       = metric_query.value.label
      return_data = metric_query.value.return_data

      metric {
        metric_name = metric_query.value.metric.metric_name
        namespace   = metric_query.value.metric.namespace
        period      = metric_query.value.metric.period
        stat        = metric_query.value.metric.stat
        unit        = metric_query.value.metric.unit
        dimensions  = metric_query.value.metric.dimensions
      }
    }
  }

  tags = var.tags
}
