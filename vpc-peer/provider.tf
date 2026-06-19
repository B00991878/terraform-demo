terraform {
  required_providers {
    aws = {
        source = "hashicorp/aws"
        version = "~> 6.0"
    }
  }
}

provider "aws" {
    region = "us-east-1"
    alias = "primary"
    profile = "terraform"
}

provider "aws" {
    region = "us-west-1"
    alias = "secondary"
    profile = "terraform"
}