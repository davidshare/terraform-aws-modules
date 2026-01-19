output "arn" {
  value = aws_ecs_task_definition.this.arn
}

output "arn_without_revision" {
  value = aws_ecs_task_definition.this.arn_without_revision
}

output "revision" {
  value = aws_ecs_task_definition.this.revision
}

output "family" {
  value = aws_ecs_task_definition.this.family
}

output "tags_all" {
  value = aws_ecs_task_definition.this.tags_all
}
