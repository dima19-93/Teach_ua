variable "vpc_cidr" {
  type        = string
  description = "CIDR block для VPC"
  default     = "10.0.0.0/16"
}

variable "env" {
  type        = string
  description = "Назва оточення"
  default     = "dev"
}
