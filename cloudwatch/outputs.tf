output "cloudwatch_nodejs_log" {
  description = "Cloudwatch NodeJS Log Group"
  value       = aws_cloudwatch_log_group.log-group-nodejs.id
}

output "cloudwatch_nginx_log" {
  description = "Cloudwatch Nginx Log Group"
  value       = aws_cloudwatch_log_group.log-group-nginx.id
}
