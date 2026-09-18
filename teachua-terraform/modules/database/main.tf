# Isolated Security Group for RDS MariaDB
resource "aws_security_group" "rds" {
  name        = "teachua-modular-rds-sg"
  vpc_id      = var.vpc_id
  
  ingress {
    from_port       = 3306
    to_port         = 3306
    protocol        = "tcp"
    security_groups = [var.ecs_security_group_id] 
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Subnet group placing RDS strictly into private subnets
resource "aws_db_subnet_group" "db" {
  name       = "teachua-modular-db-subnet-group"
  subnet_ids = var.private_subnets
}

resource "aws_db_parameter_group" "mariadb_config" {
  name   = "teachua-mariadb-custom-config"
  family = "mariadb10.11" # Укажите вашу версию MariaDB (она видна в aws_db_instance)

 
  parameter {
    name  = "init_connect"
    value = "SET foreign_key_checks=0;"
  }

  
  parameter {
    name  = "character_set_server"
    value = "utf8mb4"
  }

  parameter {
    name  = "collation_server"
    value = "utf8mb4_unicode_ci"
  }
}
# Provisions isolated MariaDB instance
resource "aws_db_instance" "mariadb" {
  identifier             = "teachua-modular-db"
  allocated_storage      = 20
  engine                 = "mariadb"
  engine_version         = "10.11"
  instance_class         = "db.t3.micro"
  db_name                = "teachua"
  username               = "adminserver"
  password               = var.db_password
  db_subnet_group_name   = aws_db_subnet_group.db.name
  vpc_security_group_ids = [aws_security_group.rds.id]
  publicly_accessible    = false
  skip_final_snapshot    = true
  parameter_group_name   = aws_db_parameter_group.mariadb_config.name
}

resource "aws_ssm_parameter" "db_password" {
  name        = "/teachua/prod/db_password"
  description = "The master password for the RDS MariaDB instance"
  type        = "SecureString"
  value       = var.db_password

  tags = {
    Environment = "production"
  }
}
