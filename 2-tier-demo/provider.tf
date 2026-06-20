terraform {
  required_version = "1.15.6"

  cloud {
    organization = "gangyao-terrafrom-learn"
    workspaces {
      name = "2-tier-demo"
    }
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~>6.0"
    }
  }

}

provider "aws" {
  region = var.region
}