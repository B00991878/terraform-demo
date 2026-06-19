resource "aws_security_group" "vpc_a_sg" {
  name        = "vpc_a_sg"
  description = "Security group for vpc_a"
  vpc_id      = aws_vpc.vpc_a.id
  provider    = aws.primary

  ingress {
    description = "allow SSH access"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "allow all traffic from vpc b"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = [aws_vpc.vpc_b.cidr_block]
  }

  egress {
    description = "allow all outbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name        = "vpc-a-sg"
    Environment = "Demo"
  }
}

resource "aws_security_group" "vpc_b_sg" {
  name        = "vpc_b_sg"
  description = "Security group for vpc_b"
  vpc_id      = aws_vpc.vpc_b.id
  provider    = aws.secondary

  ingress {
    description = "allow SSH access"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "allow all traffic from vpc a"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = [aws_vpc.vpc_a.cidr_block]
  }

  egress {
    description = "allow all outbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name        = "vpc-b-sg"
    Environment = "Demo"
  }
  
}
