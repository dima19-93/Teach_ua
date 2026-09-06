variable "vpc_cidr" { 
  type        = string
  default     = "10.0.0.0/16" 
  description = "Base CIDR block for the modular VPC"
}
