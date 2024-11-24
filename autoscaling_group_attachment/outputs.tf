output "autoscaling_attachment_id" {
  description = "The ID of the Auto Scaling attachment."
  value       = aws_autoscaling_attachment.this.id
}
