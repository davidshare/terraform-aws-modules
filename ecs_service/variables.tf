# --------------------
# Required
# --------------------
variable "name" {
  description = "ECS service name"
  type        = string
}

variable "cluster" {
  description = "ECS cluster ARN or ID"
  type        = string
}

variable "task_definition" {
  description = "Task definition ARN or family:revision"
  type        = string
}

# --------------------
# Scheduling
# --------------------
variable "desired_count" {
  description = "Number of tasks to run (ignored for DAEMON strategy)"
  type        = number
  default     = 1
}

variable "launch_type" {
  description = "Launch type: EC2, FARGATE, or EXTERNAL"
  type        = string
  default     = "FARGATE"
}

variable "platform_version" {
  description = "Platform version for FARGATE (e.g., '1.4.0', 'LATEST')"
  type        = string
  default     = "LATEST"
}

# --------------------
# Networking (awsvpc mode)
# --------------------
variable "network_configuration" {
  description = "Network configuration for awsvpc tasks"
  type = object({
    assign_public_ip = bool
    subnets          = list(string)
    security_groups  = list(string)
  })
  default = null
}

# --------------------
# Load Balancer
# --------------------
variable "load_balancer" {
  description = "Load balancer configuration (ALB/NLB)"
  type = object({
    target_group_arn = string
    container_name   = string
    container_port   = number
  })
  default = null
}

variable "health_check_grace_period_seconds" {
  description = "Grace period for load balancer health checks (seconds)"
  type        = number
  default     = 300
}

# --------------------
# Deployment
# --------------------
variable "deployment_maximum_percent" {
  description = "Upper limit of running tasks during deployment (%)"
  type        = number
  default     = 200
}

variable "deployment_minimum_healthy_percent" {
  description = "Lower limit of healthy tasks during deployment (%)"
  default     = 100
  type        = number
}

variable "force_new_deployment" {
  description = "Force a new deployment (e.g., for image updates)"
  type        = bool
  default     = false
}

variable "wait_for_steady_state" {
  description = "Wait for service to reach steady state after creation/update"
  type        = bool
  default     = true
}

# --------------------
# Tags
# --------------------
variable "tags" {
  description = "Tags to apply to the ECS service"
  type        = map(string)
  default     = {}
}