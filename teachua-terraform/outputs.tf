# Final automation endpoint link production output
output "site_url" {
  value       = module.app.alb_dns
  description = "The direct public web address to open your fully deployed TeachUA application"
}
