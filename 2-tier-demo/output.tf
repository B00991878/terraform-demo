output "vpc_id" {
  value = module.vpc.vpc_id
}

output "web_server_ip" {
  value = module.ec2.ec2_public_ip
}

output "web_server_dns" {
  value = module.ec2.ec2_public_dns
}

output "application_url" {
  value = "http://${module.ec2.ec2_public_ip}"
}

output "rds_endpoint" {
  value = module.rds.db_endpoint
}

output "rds_port" {
  value = module.rds.db_port
}

output "database_name" {
  value = module.rds.db_name
}