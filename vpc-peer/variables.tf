variable "vpc_a_cidr" {
  default = "10.1.0.0/16"
}

variable "vpc_b_cidr" {
  default = "10.2.0.0/16"
}

variable "instance_type" {
  type = string
  default = "t2.micro"
}

variable "primary_key_name" {
  type = string
  default = "vpc-peer-demo"
}

variable "secondary_key_name" {
  type = string
  default = "vpc-peer-demo"
}