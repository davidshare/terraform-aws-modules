output "name" {
  description = "The name of the Elastic Beanstalk Application"
  value       = aws_elastic_beanstalk_application.this.name
}

output "arn" {
  description = "The ARN of the Elastic Beanstalk Application"
  value       = aws_elastic_beanstalk_application.this.arn
}