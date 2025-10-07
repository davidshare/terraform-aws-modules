
output "id" {
  description = "The name/id of the EKS cluster"
  value       = aws_eks_cluster.this.id
}

output "arn" {
  description = "The Amazon Resource Name (ARN) of the cluster"
  value       = aws_eks_cluster.this.arn
}

output "certificate_authority_data" {
  description = "Base64 encoded certificate data required to communicate with the cluster"
  value       = aws_eks_cluster.this.certificate_authority[0].data
}

output "endpoint" {
  description = "Endpoint for your Kubernetes API server"
  value       = aws_eks_cluster.this.endpoint
}

output "version" {
  description = "The Kubernetes server version of the cluster"
  value       = aws_eks_cluster.this.version
}

output "platform_version" {
  description = "Platform version for the cluster"
  value       = aws_eks_cluster.this.platform_version
}