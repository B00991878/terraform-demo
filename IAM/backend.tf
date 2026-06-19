terraform {
  backend "s3" {
    bucket = "gangyao-test-terraform-state"
    key = "learning/Day05/terraform.tfstate"
    encrypt = true
    use_lockfile = true
    region = "us-east-1"
    profile = "terraform"

  }
}