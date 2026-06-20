variable "project_name" {
  description = "Name of the project - used for tagging resources"
  type        = string
  default     = "day22-rds-demo"
}

variable "environment" {
  description = "Environment name (dev, staging, prod)"
  type        = string
  default     = "dev"
}

variable "region" {
  description = "AWS region to deploy resources"
  type        = string
  default     = "us-east-1"
}

# vpc config
variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
  default     = "172.16.0.0/16"
}

# ec2 config
variable "ec2_instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t3.micro"
}

# rds config
variable "db_name" {
  description = "Name of the database"
  type        = string
  default     = "webappdb"
}

variable "db_username" {
  description = "Database master username"
  type        = string
  default     = "admin"
  sensitive   = true
}

variable "db_instance_class" {
  description = "RDS instance class"
  type        = string
  default     = "db.t3.micro"
}
variable "db_allocated_storage" {
  description = "Allocated storage for RDS in GB"
  type        = number
  default     = 10
}

variable "db_engine" {
  description = "MySQL engine version"
  type        = string
  default     = "mysql"
}

variable "parameter_group_name" {
  description = "DB parameter group name"
  type        = string
  default     = "default.mysql8.0"
}

variable "storage_type" {
  description = "storage type"
  type        = string
  default     = "gp2"
}

variable "db_engine_version" {
  description = "MySQL engine version"
  type        = string
  default     = "8.0"
}