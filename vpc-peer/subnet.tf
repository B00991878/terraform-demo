resource "aws_subnet" "vpc_a_pub_subnet" {
  provider = aws.primary
  vpc_id = aws_vpc.vpc_a.id
  cidr_block = cidrsubnet(aws_vpc.vpc_a.cidr_block, 8, 0)
  availability_zone = data.aws_availability_zones.primary.names[0]
  map_public_ip_on_launch = true
  tags = {
    Name = "vpc-a-public-subnet"
    Environment = "Demo"
  }
}

resource "aws_subnet" "vpc_b_pub_subnet" {
  provider = aws.secondary
  vpc_id = aws_vpc.vpc_b.id
  cidr_block = cidrsubnet(aws_vpc.vpc_b.cidr_block, 8, 0)
  availability_zone = data.aws_availability_zones.secondary.names[0]
  map_public_ip_on_launch = true
  tags = {
    Name = "vpc-b-public-subnet"
    Environment = "Demo"
  }
}
