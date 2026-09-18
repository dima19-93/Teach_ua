# 1. The SNS topic to which CloudWatch will send the alarm signal.
resource "aws_sns_topic" "cpu_alerts" {
  name = "teachua-cpu-alerts-topic"
}

# 2. The CloudWatch alert itself for CPU > 80% for our ECS Service
resource "aws_cloudwatch_metric_alarm" "cpu_high" {
  alarm_name          = "teachua-high-cpu-alarm"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "2"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/ECS"
  period              = "120"
  statistic           = "Average"
  threshold           = "80"
  alarm_description   = "This metric monitors ECS cluster CPU utilization"
  
  # Bind the action: send a signal to our SNS topic upon an alert
  alarm_actions       = [aws_sns_topic.cpu_alerts.arn]
  ok_actions          = [aws_sns_topic.cpu_alerts.arn]

  dimensions = {
    ClusterName = "teachua-modular-cluster"
    ServiceName = "teachua-app-service"
  }
}

# 3. An AWS Lambda function that converts an AWS system alert into nicely formatted text for Discord.
resource "aws_lambda_function" "discord_notifier" {
  filename      = "lambda_function.zip"
  function_name = "teachua-cloudwatch-to-discord"
  role          = aws_iam_role.lambda_role.arn
  handler       = "index.handler"
  runtime       = "nodejs18.x"

  environment {
    variables = {
      # We pass the name of our secret parameter from the Discord URL.
      DISCORD_WEBHOOK_PARAM = "/teachua/monitoring/cloudwatch_webhook_url"
    }
  }
}

# 4. We allow the SNS topic to ping our Lambda function.
resource "aws_sns_topic_subscription" "lambda" {
  topic_arn = aws_sns_topic.cpu_alerts.arn
  protocol  = "lambda"
  endpoint  = aws_lambda_function.discord_notifier.arn
}

resource "aws_lambda_permission" "with_sns" {
  statement_id  = "AllowExecutionFromSNS"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.discord_notifier.function_name
  principal     = "sns.amazonaws.com"
  source_arn    = aws_sns_topic.cpu_alerts.arn
}

# IAM role for Lambda (to allow it to read from Parameter Store and write logs)
resource "aws_iam_role" "lambda_role" {
  name = "teachua-lambda-discord-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Principal = { Service = "lambda.amazonaws.com" }
    }]
  })
}

resource "aws_iam_role_policy" "lambda_policy" {
  name = "teachua-lambda-policy"
  role = aws_iam_role.lambda_role.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = ["ssm:GetParameter"]
        Resource = "*"
      },
      {
        Effect = "Allow"
        Action = ["logs:CreateLogGroup", "logs:CreateLogStream", "logs:PutLogEvents"]
        Resource = "*"
      }
    ]
  })
}
