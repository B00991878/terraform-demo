variable "vpc_cidr" {
  default     = "10.0.0.0/16"
  type        = string
  description = "vpc cidr"
}

variable "public_subnet_cidr" {
  default     = ["10.0.1.0/24"]
  type        = list(string)
  description = "public subnet cidr"
}

variable "private_subnet_cidr" {
  default     = ["10.0.2.0/24"]
  type        = list(string)
  description = "private subnet cidr"
}

variable "environment" {
  default = "dev"
}

variable "region" {
  default = "us-east-1"
}

variable "project_name" {
  description = "Name of the project"
  type        = string
}

variable "public_availability_zone" {
  type    = list(string)
  default = ["us-east-1a"]
}

variable "private_availability_zone" {
  type    = list(string)
  default = ["us-east-1a"]
}

variable "default_tags" {
  type = map(string)
  default = {
    Environment = "dev"
  }
}

variable "public_subnet_tags" {
  description = "Additional tags for public subnets"
  type        = map(string)
  default     = {}
}

variable "private_subnet_tags" {
  description = "Additional tags for private subnets"
  type        = map(string)
  default     = {}
}

