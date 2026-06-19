resource "aws_internet_gateway" "primary_igw" {
    provider = aws.primary
    vpc_id = aws_vpc.vpc_a.id
    tags ={
        Name = "Primary IGW"
      Environment = "Demo"
    }
}

resource "aws_internet_gateway" "secondary_igw"{
    vpc_id = aws_vpc.vpc_b.id
    tags ={
      Name = "Secondary IGW"
      Environment = "Demo"
    }
    provider = aws.secondary
}