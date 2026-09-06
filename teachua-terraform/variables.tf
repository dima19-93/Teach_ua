variable "db_password" {
  type        = string
  description = "Master password for MariaDB cloud database"
  sensitive   = true
}
