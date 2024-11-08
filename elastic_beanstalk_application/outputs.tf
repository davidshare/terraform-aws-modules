output "elastic_beanstalk_application_name" {
  description = "The name of the Elastic Beanstalk Application"
  value       = aws_elastic_beanstalk_application.this.name
}

output "elastic_beanstalk_application_arn" {
  description = "The ARN of the Elastic Beanstalk Application"
  value       = aws_elastic_beanstalk_application.this.arn
}