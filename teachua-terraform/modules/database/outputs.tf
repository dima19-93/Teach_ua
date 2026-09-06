output "db_endpoint" { 
  value       = aws_db_instance.mariadb.endpoint 
  description = "The connection endpoint for the private RDS instance"
}

output "db_address" {
  value = aws_db_instance.mariadb.address 
}
