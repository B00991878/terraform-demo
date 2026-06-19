resource "aws_iam_user" "users" {
  for_each = { for user in local.users : "${user.first_name}-${user.last_name}" => user }
  name = each.key
  path = "/users/"

  tags = {
    Name = "${each.value.first_name} ${each.value.last_name}"
    Department = each.value.department
    Title = each.value.title
  }
}

resource "aws_iam_user_login_profile" "login_profiles" {
  for_each = aws_iam_user.users
  user = each.value.name
  password_reset_required = true

  lifecycle {
    ignore_changes = [ password_reset_required, password_length ]
  }

}

resource "aws_iam_group" "IT_group" {
  name = "IT"
  path = "/groups/"

}

resource "aws_iam_group" "sale_group" {
  name = "sale"
  path = "/groups/"
}

resource "aws_iam_group" "maneger_group" {
  name = "maneger"
  path = "/groups/"
}

resource "aws_iam_group_membership" "IT_members" {
    name = "IT-group-membership"
    group = aws_iam_group.IT_group.name
    users = [for user in aws_iam_user.users : user.name if user.tags.Department == "IT"]
}



resource "aws_iam_group_membership" "sale_members" {
    name = "sale-group-membership"
    group = aws_iam_group.sale_group.name
    users = [for user in aws_iam_user.users : user.name if user.tags.Department == "sales"]
}

resource "aws_iam_group_membership" "maneger_members" {
    name = "maneger-group-membership"
    group = aws_iam_group.maneger_group.name
    users = [for user in aws_iam_user.users : user.name if can(regex("(?i)manager|CEO", lookup(user.tags,"Title","")))]
}


resource "aws_iam_group_policy_attachment" "modify_password" {
    group      = aws_iam_group.IT_group.name
    policy_arn = "arn:aws:iam::aws:policy/IAMUserChangePassword"
}


resource "aws_iam_group_policy_attachment" "modify_password2" {
    group      = aws_iam_group.maneger_group.id
    policy_arn = "arn:aws:iam::aws:policy/IAMUserChangePassword"
}

resource "aws_iam_group_policy_attachment" "modify_password3" {
    group      = aws_iam_group.sale_group.id
    policy_arn = "arn:aws:iam::aws:policy/IAMUserChangePassword"
}