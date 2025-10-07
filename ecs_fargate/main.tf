resource "aws_ecs_cluster" "this" {
  name = var.cluster_name
  tags = var.tags
}

resource "aws_ecs_task_definition" "this" {
  family                   = var.task_family
  container_definitions    = var.container_definitions
  cpu                      = var.cpu
  memory                   = var.memory
  network_mode             = var.network_mode
  execution_role_arn       = var.execution_role_arn
  task_role_arn            = var.task_role_arn
  requires_compatibilities = ["FARGATE"]

  tags = var.tags
}

resource "aws_ecs_service" "this" {
  name            = var.service_name
  cluster         = aws_ecs_cluster.this.id
  task_definition = aws_ecs_task_definition.this.arn
  desired_count   = var.desired_count
  launch_type     = var.launch_type

  network_configuration {
    subnets          = var.subnets
    security_groups  = var.security_groups
    assign_public_ip = var.assign_public_ip
  }

  tags = var.tags
}
