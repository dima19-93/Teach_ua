variable "vpc_id" { type = string }
variable "public_subnets" { type = list(string) }
variable "private_subnets" { type = list(string) }
variable "db_endpoint" { type = string }
variable "ecs_sg_id" { type = string }

# Securely passing database password to container definitions
variable "db_password" {
  type      = string
  sensitive = true
}
