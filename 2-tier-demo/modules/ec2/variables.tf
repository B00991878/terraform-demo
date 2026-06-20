variable "project_name" {
  description = "Name of the project"
  type        = string
}

variable "region" {
  type    = string
  default = "us-east-1"
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t3.micro"
}

variable "public_subnet_id" {
  description = "ID of the public subnet"
  type        = string
}

variable "environment" {
  description = "Environment name"
  type        = string
}

variable "web_security_group_id" {
  description = "Security group ID for the web server"
  type        = string
}

variable "db_credentials_arn" {
  description = "Database secret arn"
  type        = string
}

variable "iam_instance_profile_name" {
  description = "IAM instance profile name for EC2 to access Secrets Manager"
  type        = string
}
