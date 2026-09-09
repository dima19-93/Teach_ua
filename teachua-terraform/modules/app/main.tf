data "aws_iam_role" "ecs_execution" {
  name = "ecsTaskExecutionRole"
}

# Firewall for Load Balancer
resource "aws_security_group" "alb" {
  vpc_id = var.vpc_id
  
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

}

# ALB stays in public subnets to receive internet traffic
resource "aws_lb" "alb" {
  name               = "teachua-modular-alb"
  load_balancer_type = "application"
  security_groups    = [aws_security_group.alb.id]
  subnets            = var.public_subnets
}

# Target Group for Spring Boot Backend service
resource "aws_lb_target_group" "backend" {
  name        = "teachua-mod-back-tg"
  port        = 8080
  protocol    = "HTTP"
  vpc_id      = var.vpc_id
  target_type = "ip"

  health_check {
    path                = "/"
    port                = "8080"
    healthy_threshold   = 2
    unhealthy_threshold = 5
    interval            = 30
    timeout             = 5
    matcher             = "200-499" 
  }
}

# Target Group for React Frontend service
resource "aws_lb_target_group" "frontend" {
  name        = "teachua-mod-front-tg"
  port        = 80
  protocol    = "HTTP"
  vpc_id      = var.vpc_id
  target_type = "ip"
}

# Main listener routing traffic to Frontend by default
resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.alb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.frontend.arn
  }
}

# Core ECS Cluster hosting Fargate tasks
resource "aws_ecs_cluster" "main" {
  name = "teachua-modular-cluster"
}


# Task definition for Backend containing precise properties from README.md specification
resource "aws_ecs_task_definition" "backend" {
  family                   = "teachua-backend-task"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = "1024"
  memory                   = "2048"
  execution_role_arn       = data.aws_iam_role.ecs_execution.arn
  
  container_definitions = jsonencode([
  {
    name      = "backend"
    image     = "908456387091.dkr.ecr.eu-central-1.amazonaws.com/teachua-backend:latest"
    cpu       = 1024
    memory    = 2048
    essential = true
    
    portMappings = [
      {
        containerPort = 8080
        hostPort      = 8080
      }
    ]

    environment = [
      { name = "JDBC_DRIVER", value = "org.mariadb.jdbc.Driver" },
      { name = "DATASOURCE_URL", value = "jdbc:mariadb://${var.db_endpoint}:3306/teachua?useUnicode=true&characterEncoding=UTF-8" },
      { name = "DATASOURCE_USER", value = "adminserver" },
      { name = "DATASOURCE_PASSWORD", value = var.db_password },
      { name = "spring.profiles.active", value = "dev" },

      { name = "SPRING_SQL_INIT_MODE", value = "always" },
      { name = "SPRING_SQL_INIT_DATA_LOCATIONS", value = "file:/app/data.sql" },
      { name = "SPRING_JPA_DEFER_DATASOURCE_INITIALIZATION", value = "true" },
      { name = "SPRING_SQL_INIT_CONTINUE_ON_ERROR", value = "true" },
      
    ]
   }  
  ])
  }

# Task definition for React Frontend application
resource "aws_ecs_task_definition" "frontend" {
  family                   = "teachua-frontend-task"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = "1024"
  memory                   = "2048"
  execution_role_arn       = data.aws_iam_role.ecs_execution.arn

  container_definitions = jsonencode([{
    name = "frontend"
    image = "908456387091.dkr.ecr.eu-central-1.amazonaws.com/teachua-frontend:latest"
    cpu = 1024
    memory = 2048
    essential = true
    portMappings = [
        {
          containerPort = 80
          hostPort      = 80
        }
      ]

      
      environment = [
        { name = "REACT_APP_ROOT_SERVER", value = "http://teachua-modular-alb-48036850.eu-central-1.elb.amazonaws.com" }

      ]
    }
  ])
}

# ECS Backend Service moves strictly to PRIVATE subnets
resource "aws_ecs_service" "backend" {
  name                              = "teachua-backend-service"
  cluster                           = aws_ecs_cluster.main.id
  task_definition                   = aws_ecs_task_definition.backend.arn
  desired_count                     = 1
  launch_type                       = "FARGATE"
  health_check_grace_period_seconds = 120

  network_configuration {
    subnets          = var.private_subnets
    security_groups  = [var.ecs_sg_id]
    assign_public_ip = false
  }
}

# ECS Frontend Service moves strictly to PRIVATE subnets
resource "aws_ecs_service" "frontend" {
  name            = "teachua-frontend-service"
  cluster         = aws_ecs_cluster.main.id
  task_definition = aws_ecs_task_definition.frontend.arn
  desired_count   = 1
  launch_type     = "FARGATE"

  network_configuration {
    subnets          = var.private_subnets
    security_groups  = [var.ecs_sg_id]
    assign_public_ip = false
  }

  load_balancer {
    target_group_arn = aws_lb_target_group.frontend.arn
    container_name   = "frontend"
    container_port   = 3000
  }
}
