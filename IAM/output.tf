output "account_id" {
  value = data.aws_caller_identity.caller.account_id
}

output "user_names" {
  value = [for user in local.users: "${user.first_name} ${user.last_name}"]
}

output "passwords" {
  value = {
    for username,profile in aws_iam_user_login_profile.login_profiles:
      username => profile.password
  } 
  sensitive = true
}