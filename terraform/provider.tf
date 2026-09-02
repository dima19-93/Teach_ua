terraform {
  # Мінімальна версія самого Terraform
  required_version = ">= 1.5.0"

  # Завантажуємо офіційний плагін для роботи з AWS
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

# Конфігурація підключення до AWS
provider "aws" {
  region = var.aws_region

  # Автоматичне додавання тегів до всіх ресурсів для контролю витрат
  default_tags {
    tags = {
      Project   = "Teach-UA"
      ManagedBy = "Terraform"
      Env       = var.environment
    }
  }
}
