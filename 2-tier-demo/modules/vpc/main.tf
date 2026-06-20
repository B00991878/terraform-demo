# create vpc
resource "aws_vpc" "main_vpc" {
  cidr_block           = var.vpc_cidr
  enable_dns_hostnames = true
  enable_dns_support   = true
  instance_tenancy     = "default"

  tags = {
    Name = "${var.project_name}-vpc"
  }
}

# public subnets
resource "aws_subnet" "public_subnet" {
  vpc_id                  = aws_vpc.main_vpc.id
  count                   = length(var.public_subnet_cidr)
  cidr_block              = var.public_subnet_cidr[count.index]
  availability_zone       = var.public_availability_zone[count.index]
  map_public_ip_on_launch = true
  tags = merge(
    var.default_tags,
    var.public_subnet_tags,
    {
      Name = "${var.project_name}-public-subnet-${count.index}"
    }
  )
}

# private subnets
resource "aws_subnet" "private_subnet" {
  vpc_id            = aws_vpc.main_vpc.id
  count             = length(var.private_subnet_cidr)
  cidr_block        = var.private_subnet_cidr[count.index]
  availability_zone = var.private_availability_zone[count.index]

  tags = merge(
    var.default_tags,
    var.private_subnet_tags,
    {
      Name = "${var.project_name}-private-subnet-${count.index}"
    }
  )
}

# internet gateway and route table
resource "aws_internet_gateway" "main_igw" {
  vpc_id = aws_vpc.main_vpc.id
  tags = merge(
    var.default_tags,
    {
      Name = "${var.project_name}-igw"
    }
  )
}

resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.main_vpc.id
  tags = merge(
    var.default_tags,
    {
      Name = "${var.project_name}-rtb"
    }
  )
}

# default route
resource "aws_route" "default_route" {
  route_table_id         = aws_route_table.public_route_table.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.main_igw.id
}

# route table association
resource "aws_route_table_association" "public_route_table_association" {
  count          = length(var.public_subnet_cidr)
  subnet_id      = aws_subnet.public_subnet[count.index].id
  route_table_id = aws_route_table.public_route_table.id
}
