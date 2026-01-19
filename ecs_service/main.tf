resource "aws_ecs_service" "this" {
  name            = var.name
  cluster         = var.cluster
  task_definition = var.task_definition
  desired_count   = var.desired_count
  launch_type     = var.launch_type

  # Only set platform_version for FARGATE
  platform_version = var.launch_type == "FARGATE" ? var.platform_version : null

  # Networking (required for awsvpc)
  dynamic "network_configuration" {
    for_each = var.network_configuration != null ? [var.network_configuration] : []
    content {
      assign_public_ip = network_configuration.value.assign_public_ip
      subnets          = network_configuration.value.subnets
      security_groups  = network_configuration.value.security_groups
    }
  }

  # Load balancer
  dynamic "load_balancer" {
    for_each = var.load_balancer != null ? [var.load_balancer] : []
    content {
      target_group_arn = load_balancer.value.target_group_arn
      container_name   = load_balancer.value.container_name
      container_port   = load_balancer.value.container_port
    }
  }

  # Health check grace period (only if using LB)
  health_check_grace_period_seconds = var.load_balancer != null ? var.health_check_grace_period_seconds : null

  # Deployment settings
  deployment_maximum_percent         = var.deployment_maximum_percent
  deployment_minimum_healthy_percent = var.deployment_minimum_healthy_percent
  force_new_deployment               = var.force_new_deployment
  wait_for_steady_state              = var.wait_for_steady_state

  # Tags
  tags = var.tags
}