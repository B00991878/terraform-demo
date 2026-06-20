variable "project_name" {
  description = "Project name"
  type        = string
}

variable "environment" {
  description = "Environment name"
  type        = string
}

variable "db_credentials_arn" {
  description = "ARN of the Secrets Manager secret containing database credentials"
  type        = string
}