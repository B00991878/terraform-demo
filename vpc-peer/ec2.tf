resource "aws_instance" "instance-a" {
    provider = aws.primary
    ami = data.aws_ami.primary.id
    instance_type = var.instance_type
    subnet_id = aws_subnet.vpc_a_pub_subnet.id
    vpc_security_group_ids = [aws_security_group.vpc_a_sg.id]
    key_name = var.primary_key_name

    user_data = local.user_data

    depends_on = [
      aws_route.vpc_peer_a_to_b,
      aws_route.vpc_peer_b_to_a
    ]

    tags = {
      Name = "vpc-a-instance"
      Environment = "Demo"
    }
}


resource "aws_instance" "instance-b" {
  provider = aws.secondary
  ami = data.aws_ami.secondary.id
  instance_type = var.instance_type
  subnet_id = aws_subnet.vpc_b_pub_subnet.id
  vpc_security_group_ids = [aws_security_group.vpc_b_sg.id]
  key_name = var.secondary_key_name

  user_data = local.user_data

  depends_on = [
    aws_route.vpc_peer_a_to_b,
    aws_route.vpc_peer_b_to_a
  ]

  tags = {
    Name = "vpc-b-instance"
    Environment = "Demo"
  }
}