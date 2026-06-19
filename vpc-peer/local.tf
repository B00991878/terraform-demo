locals {
  user_data = <<-EOF
#!/bin/bash
dnf update -y || yum update -y
dnf install -y nginx || amazon-linux-extras install nginx1 -y || yum install -y nginx

systemctl enable nginx
systemctl start nginx

cat > /usr/share/nginx/html/index.html <<HTML
<!DOCTYPE html>
<html>
<head>
  <title>VPC Peering Demo</title>
</head>
<body>
  <h1>Nginx is running</h1>
  <p>Instance: $(hostname)</p>
</body>
</html>
HTML
EOF
}