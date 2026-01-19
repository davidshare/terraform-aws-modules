output "id" {
  description = "ID of the ECS cluster"
  value       = aws_ecs_cluster.this.id
}

output "arn" {
  description = "ARN of the ECS cluster"
  value       = aws_ecs_cluster.this.arn
}

output "name" {
  description = "Name of the ECS cluster"
  value       = aws_ecs_cluster.this.name
}

output "tags_all" {
  description = "All tags assigned to the ECS cluster"
  value       = aws_ecs_cluster.this.tags_all
}