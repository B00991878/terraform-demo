data "aws_availability_zones" "primary" {
  provider = aws.primary
  state = "available"
}

data "aws_availability_zones" "secondary" {
  provider = aws.secondary
  state = "available"
}

data "aws_ami" "primary" {
    provider = aws.primary
    most_recent = true
    owners = ["amazon"]
    filter {
        name = "name"
        values = [ "amzn2-ami-hvm-*-x86_64-gp2" ]
    }

    filter {
    name = "virtualization-type"
    values = [ "hvm" ]
    }
    filter {
      name = "architecture"
      values = [ "x86_64" ]
    }
}

data "aws_ami" "secondary" {
    provider = aws.secondary
    most_recent = true
    owners = ["amazon"]
    filter {
        name = "name"
        values = [ "amzn2-ami-hvm-*-x86_64-gp2" ]
    }
    filter {
        name = "virtualization-type"
        values = [ "hvm" ]
    }
    filter {
        name = "architecture"
        values = [ "x86_64" ]
    }
}
