terraform {
  backend "s3" {
    bucket = "gangyao-test-terraform-state"
    key = "learning/vpc-peer/terraform.tfstate"
    region = "us-east-1"
    profile = "terraform"
    encrypt = true
    use_lockfile = true
  }
}