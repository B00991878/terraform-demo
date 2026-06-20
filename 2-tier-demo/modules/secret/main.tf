resource "aws_secretsmanager_secret" "db_credentials" {

  name        = "${var.project_name}-${var.environment}-db-password-v2"
  description = "Database password for ${var.project_name}-${var.environment}"
  tags = {
    Name        = "${var.project_name}-db-password"
    Environment = var.environment
  }
}

resource "aws_secretsmanager_secret_version" "db_credentials" {
  secret_id     = aws_secretsmanager_secret.db_credentials.id
  secret_string = jsonencode({
    username = var.db_username
    password = var.db_password
    host     = var.db_host
    port     = var.db_port
    dbname   = var.db_name
  })
}