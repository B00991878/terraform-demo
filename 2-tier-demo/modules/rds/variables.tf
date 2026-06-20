variable "project_name" {
  description = "Name of the project"
  type        = string
}

variable "environment" {
  description = "Environment name"
  type        = string
}

variable "instance_class" {
  description = "DB instance type"
  type        = string
  default     = "db.t3.micro"
}

variable "private_subnet_ids" {
  description = "ID of the public subnet"
  type        = list(string)
}


variable "db_security_group_id" {
  description = "Security group ID for the web server"
  type        = string
}


variable "db_username" {
  description = "Database username"
  type        = string
  sensitive   = true
}


variable "db_name" {
  description = "Database name"
  type        = string
}

variable "allocated_storage" {
  description = "Allocated storage in GB"
  type        = number
  default     = 10
}

variable "engine" {
  description = "storage engine"
  type        = string
  default     = "mysql"
}

variable "engine_version" {
  description = "storage engine version"
  type        = string
  default     = "8.0"
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

