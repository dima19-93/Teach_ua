output "vpc_id" { 
  value       = aws_vpc.main.id 
  description = "The ID of the created VPC"
}

output "public_subnets" { 
  value       = [aws_subnet.public_1.id, aws_subnet.public_2.id] 
  description = "List of public subnet IDs"
}

output "private_subnets" { 
  value       = [aws_subnet.private_1.id, aws_subnet.private_2.id] 
  description = "List of isolated private subnet IDs for database and ECS applications"
}

output "ecs_sg_id" {
  value       = aws_security_group.ecs.id
  description = "The Security Group ID for ECS tasks"
}

output "ecs_security_group_id" {
  value       = aws_security_group.ecs.id
  description = "ECS security group ID exported from the network module"
}
