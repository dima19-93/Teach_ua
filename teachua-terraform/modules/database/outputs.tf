output "db_endpoint" { 
  value       = aws_db_instance.mariadb.endpoint 
  description = "The connection endpoint for the private RDS instance"
}

output "db_address" {
  value = aws_db_instance.mariadb.address 
}


output "db_password_parameter_arn" {
  value       = aws_ssm_parameter.db_password.arn
  description = "The ARN of the secret password in SSM Parameter Store"
}
