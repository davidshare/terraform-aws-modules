output "group_id" {
  description = "EKS Node Group ID"
  value       = aws_eks_node_group.this.id
}

output "group_arn" {
  description = "Amazon Resource Name (ARN) of the EKS Node Group"
  value       = aws_eks_node_group.this.arn
}

output "group_status" {
  description = "Status of the EKS Node Group"
  value       = aws_eks_node_group.this.status
}

output "group_resources" {
  description = "List of objects containing information about underlying resources of the EKS Node Group"
  value       = aws_eks_node_group.this.resources
}