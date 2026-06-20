data "aws_iam_policy_document" "ec2_assume_role" {
  statement {
    actions = ["sts:AssumeRole"]
    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }
    effect = "Allow"
  }
}
data "aws_iam_policy_document" "ec2_secret_access" {
  statement {
    actions   = ["secretsmanager:GetSecretValue"]
    effect    = "Allow"
    resources = [var.db_credentials_arn]
  }
}
resource "aws_iam_role" "ec2_secret_access_role" {
  name               = "${var.project_name}-${var.environment}-ec2-role"
  assume_role_policy = data.aws_iam_policy_document.ec2_assume_role.json
  tags = {
    Name        = "${var.project_name}-ec2-role"
    Environment = var.environment
  }
}

resource "aws_iam_policy" "ec2_secret_access_policy" {
  name   = "${var.project_name}-${var.environment}-ec2-role-policy"
  policy = data.aws_iam_policy_document.ec2_secret_access.json
  tags = {
    Name        = "${var.project_name}-read-db-secret-policy"
    Environment = var.environment
  }
}

resource "aws_iam_role_policy_attachment" "ec2_secret_access_role_attachment" {
  role       = aws_iam_role.ec2_secret_access_role.name
  policy_arn = aws_iam_policy.ec2_secret_access_policy.arn
}

resource "aws_iam_instance_profile" "ec2_secret_access_profile" {
  name = "${var.project_name}-${var.environment}-ec2-instance-profile"
  role = aws_iam_role.ec2_secret_access_role.name
  tags = {
    Name        = "${var.project_name}-ec2-instance-profile"
    Environment = var.environment
  }
}

