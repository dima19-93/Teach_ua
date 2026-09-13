terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = "eu-central-1"
}
#Deploy the network along with the ECS Security Group
module "network" {
  source = "./modules/network"
}
#Deploy the database using the SG from the network module
module "database" {
  source                = "./modules/database"
  vpc_id                = module.network.vpc_id
  private_subnets       = module.network.private_subnets
  ecs_sg_id             = module.network.ecs_sg_id
  db_password           = var.db_password
  ecs_security_group_id = module.network.ecs_security_group_id 
}
#We launch ECS services and ALB using computed database inputs
module "app" {
  source                    = "./modules/app"
  vpc_id                    = module.network.vpc_id
  public_subnets            = module.network.public_subnets
  private_subnets           = module.network.private_subnets
  ecs_sg_id                 = module.network.ecs_sg_id
  db_endpoint               = module.database.db_address
  db_password               = var.db_password
  db_password_parameter_arn = module.database.db_password_parameter_arn
}


