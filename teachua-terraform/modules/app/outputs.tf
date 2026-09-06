output "alb_dns" { 
  value       = aws_lb.alb.dns_name 
  description = "The public DNS name of the Application Load Balancer"
}

