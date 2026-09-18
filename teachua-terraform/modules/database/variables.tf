variable "vpc_id" { type = string }
variable "private_subnets" { type = list(string) }
variable "ecs_sg_id" { type = string }

# Secure variable for database password (no default value!)
variable "db_password" {
  type        = string
  description = "The master password for the RDS MariaDB instance"
  sensitive   = true # This flag hides the password from being printed in terminal logs
}

variable "ecs_security_group_id" {
  type        = string
  description = "ECS container security group ID for RDS access"
}
