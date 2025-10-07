resource "aws_autoscaling_policy" "this" {
  name                      = var.name
  autoscaling_group_name    = var.autoscaling_group_name
  adjustment_type           = var.adjustment_type
  policy_type               = var.policy_type
  estimated_instance_warmup = var.estimated_instance_warmup
  enabled                   = var.enabled

  dynamic "predictive_scaling_configuration" {
    for_each = var.predictive_scaling_configuration != null ? [var.predictive_scaling_configuration] : []
    content {
      max_capacity_breach_behavior = predictive_scaling_configuration.value.max_capacity_breach_behavior
      max_capacity_buffer          = predictive_scaling_configuration.value.max_capacity_buffer
      mode                         = predictive_scaling_configuration.value.mode
      scheduling_buffer_time       = predictive_scaling_configuration.value.scheduling_buffer_time

      dynamic "metric_specification" {
        for_each = predictive_scaling_configuration.value.metric_specification != null ? [predictive_scaling_configuration.value.metric_specification] : []
        content {
          target_value = 10
          dynamic "customized_capacity_metric_specification" {
            for_each = metric_specification.value.customized_capacity_metric_specification != null ? [metric_specification.value.customized_capacity_metric_specification] : []
            content {
              dynamic "metric_data_queries" {
                for_each = customized_capacity_metric_specification.value.metric_data_queries
                content {
                  id          = metric_data_queries.value.id
                  expression  = lookup(metric_data_queries.value, "expression", null)
                  label       = lookup(metric_data_queries.value, "label", null)
                  return_data = lookup(metric_data_queries.value, "return_data", null)
                  dynamic "metric_stat" {
                    for_each = lookup(metric_data_queries.value, "metric_stat", null) != null ? [metric_data_queries.value.metric_stat] : []
                    content {
                      metric {
                        metric_name = metric_stat.value.metric.metric_name
                        namespace   = metric_stat.value.metric.namespace
                        dynamic "dimensions" {
                          for_each = lookup(metric_data_queries.value.metric_stat.metric, "dimensions", null) != null ? metric_data_queries.value.metric_stat.metric.dimensions : {}
                          content {
                            name  = "AutoScalingGroupName"
                            value = "my-test-asg"
                          }
                        }
                      }
                      stat = metric_stat.value.stat
                      unit = lookup(metric_stat.value, "unit", null)
                    }
                  }
                }
              }
            }
          }
          dynamic "customized_load_metric_specification" {
            for_each = metric_specification.value.customized_load_metric_specification != null ? [metric_specification.value.customized_load_metric_specification] : []
            content {
              dynamic "metric_data_queries" {
                for_each = customized_load_metric_specification.value.metric_data_queries
                content {
                  id          = metric_data_queries.value.id
                  expression  = lookup(metric_data_queries.value, "expression", null)
                  label       = lookup(metric_data_queries.value, "label", null)
                  return_data = lookup(metric_data_queries.value, "return_data", null)
                  dynamic "metric_stat" {
                    for_each = lookup(metric_data_queries.value, "metric_stat", null) != null ? [metric_data_queries.value.metric_stat] : []
                    content {
                      metric {
                        metric_name = metric_stat.value.metric.metric_name
                        namespace   = metric_stat.value.metric.namespace
                        dynamic "dimensions" {
                          for_each = lookup(metric_data_queries.value.metric_stat.metric, "dimensions", null) != null ? metric_data_queries.value.metric_stat.metric.dimensions : {}
                          content {
                            name  = "AutoScalingGroupName"
                            value = "my-test-asg"
                          }
                        }
                      }
                      stat = metric_stat.value.stat
                      unit = lookup(metric_stat.value, "unit", null)
                    }
                  }
                }
              }
            }
          }
          dynamic "customized_scaling_metric_specification" {
            for_each = metric_specification.value.customized_scaling_metric_specification != null ? [metric_specification.value.customized_scaling_metric_specification] : []
            content {
              dynamic "metric_data_queries" {
                for_each = customized_scaling_metric_specification.value.metric_data_queries
                content {
                  id          = metric_data_queries.value.id
                  expression  = lookup(metric_data_queries.value, "expression", null)
                  label       = lookup(metric_data_queries.value, "label", null)
                  return_data = lookup(metric_data_queries.value, "return_data", null)
                  dynamic "metric_stat" {
                    for_each = lookup(metric_data_queries.value, "metric_stat", null) != null ? [metric_data_queries.value.metric_stat] : []
                    content {
                      metric {
                        metric_name = metric_stat.value.metric.metric_name
                        namespace   = metric_stat.value.metric.namespace
                        dynamic "dimensions" {
                          for_each = lookup(metric_data_queries.value.metric_stat.metric, "dimensions", null) != null ? metric_data_queries.value.metric_stat.metric.dimensions : {}
                          content {
                            name  = "AutoScalingGroupName"
                            value = "my-test-asg"
                          }
                        }
                      }
                      stat = metric_stat.value.stat
                      unit = lookup(metric_stat.value, "unit", null)
                    }
                  }
                }
              }
            }
          }
          dynamic "predefined_load_metric_specification" {
            for_each = metric_specification.value.predefined_load_metric_specification != null ? [metric_specification.value.predefined_load_metric_specification] : []
            content {
              predefined_metric_type = predefined_load_metric_specification.value.predefined_metric_type
              resource_label         = predefined_load_metric_specification.value.resource_label
            }
          }
          dynamic "predefined_metric_pair_specification" {
            for_each = metric_specification.value.predefined_metric_pair_specification != null ? [metric_specification.value.predefined_metric_pair_specification] : []
            content {
              predefined_metric_type = predefined_metric_pair_specification.value.predefined_metric_type
              resource_label         = predefined_metric_pair_specification.value.resource_label
            }
          }
          dynamic "predefined_scaling_metric_specification" {
            for_each = metric_specification.value.predefined_scaling_metric_specification != null ? [metric_specification.value.predefined_scaling_metric_specification] : []
            content {
              predefined_metric_type = predefined_scaling_metric_specification.value.predefined_metric_type
              resource_label         = predefined_scaling_metric_specification.value.resource_label
            }
          }
        }
      }
    }
  }

  min_adjustment_magnitude = var.min_adjustment_magnitude

  cooldown           = var.cooldown
  scaling_adjustment = var.scaling_adjustment

  metric_aggregation_type = var.metric_aggregation_type

  dynamic "step_adjustment" {
    for_each = var.step_adjustment
    content {
      scaling_adjustment          = step_adjustment.value.scaling_adjustment
      metric_interval_lower_bound = lookup(step_adjustment.value, "metric_interval_lower_bound", null)
      metric_interval_upper_bound = lookup(step_adjustment.value, "metric_interval_upper_bound", null)
    }
  }

  dynamic "target_tracking_configuration" {
    for_each = var.target_tracking_configuration != null ? [var.target_tracking_configuration] : []
    content {
      target_value     = target_tracking_configuration.value.target_value
      disable_scale_in = lookup(target_tracking_configuration.value, "disable_scale_in", null)

      dynamic "predefined_metric_specification" {
        for_each = lookup(target_tracking_configuration.value, "predefined_metric_specification", null) != null ? [target_tracking_configuration.value.predefined_metric_specification] : []
        content {
          predefined_metric_type = predefined_metric_specification.value.predefined_metric_type
          resource_label         = lookup(predefined_metric_specification.value, "resource_label", null)
        }
      }

      dynamic "customized_metric_specification" {
        for_each = lookup(target_tracking_configuration.value, "customized_metric_specification", null) != null ? [target_tracking_configuration.value.customized_metric_specification] : []
        content {
          metric_name = lookup(customized_metric_specification.value, "metric_name", null)
          namespace   = lookup(customized_metric_specification.value, "namespace", null)
          statistic   = lookup(customized_metric_specification.value, "statistic", null)
          unit        = lookup(customized_metric_specification.value, "unit", null)

          dynamic "metric_dimension" {
            for_each = lookup(customized_metric_specification.value, "metric_dimension", [])
            content {
              name  = metric_dimension.value.name
              value = metric_dimension.value.value
            }
          }
        }
      }
    }
  }
}
