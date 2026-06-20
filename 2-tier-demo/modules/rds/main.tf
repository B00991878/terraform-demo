resource "random_password" "db_password" {
  length           = 16
  special          = true
  override_special = "#$%&*()-_=+[]{}<>:?"
}
resource "aws_db_subnet_group" "web_db_group" {
  subnet_ids = var.private_subnet_ids
  name       = "${var.project_name}-db-subnet-group"
}

resource "aws_db_instance" "web_db" {
  identifier             = "${var.project_name}-db"
  engine                 = var.engine
  engine_version         = var.engine_version
  storage_type           = var.storage_type
  db_name                = var.db_name
  parameter_group_name   = var.parameter_group_name
  username               = var.db_username
  password               = random_password.db_password.result
  instance_class         = var.instance_class
  allocated_storage      = var.allocated_storage
  db_subnet_group_name   = aws_db_subnet_group.web_db_group.name
  vpc_security_group_ids = [var.db_security_group_id]
  skip_final_snapshot    = true
  publicly_accessible    = false

  tags = {
    Name        = "${var.project_name}-rds"
    Environment = var.environment
  }

}