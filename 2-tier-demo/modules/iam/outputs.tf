output "ec2_role_name" {
  value = aws_iam_role.ec2_secret_access_role.name
}

output "ec2_role_arn" {
  value = aws_iam_role.ec2_secret_access_role.arn
}

output "ec2_instance_profile_name" {
  value = aws_iam_instance_profile.ec2_secret_access_profile.name
}

output "ec2_instance_profile_arn" {
  value = aws_iam_instance_profile.ec2_secret_access_profile.arn
}