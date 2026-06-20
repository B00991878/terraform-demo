output "ec2_id" {
  value = aws_instance.web_instance.id
}

output "ec2_public_ip" {
  value = aws_instance.web_instance.public_ip
}

output "ec2_public_dns" {
  value = aws_instance.web_instance.public_dns
}
