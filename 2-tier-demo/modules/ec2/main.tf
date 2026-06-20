data "aws_ami" "ubuntu" {
  most_recent = true
  owners      = ["099720109477"]
  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }
  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

resource "aws_instance" "web_instance" {
  ami                         = data.aws_ami.ubuntu.id
  subnet_id                   = var.public_subnet_id
  instance_type               = var.instance_type
  associate_public_ip_address = true
  vpc_security_group_ids      = [var.web_security_group_id]
  iam_instance_profile        = var.iam_instance_profile_name

  user_data = templatefile("${path.module}/template/userdata.sh", {
    db_credentials_arn = var.db_credentials_arn
    aws_region         = var.region
  })

  tags = {
    Name        = "${var.project_name}-web-server"
    Environment = var.environment
  }
}