resource "aws_vpc" "vpc_a" {
    provider = aws.primary
    cidr_block = var.vpc_a_cidr
    instance_tenancy = "default"
    enable_dns_hostnames = true
    enable_dns_support = true
    tags = {
        Name = "vpc-a"
        Environment = "Demo"
    }
}

resource "aws_vpc" "vpc_b" {
    provider = aws.secondary
    cidr_block = var.vpc_b_cidr
    instance_tenancy = "default"
    tags = {
        Name = "vpc-b"
        Environment = "Demo"
    }
    enable_dns_hostnames = true
    enable_dns_support = true
}

