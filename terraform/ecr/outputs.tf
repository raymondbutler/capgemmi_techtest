output "nodejs_repository_url" {
  description = "NodeJS Repository url"
  value       = aws_ecr_repository.aws-ecr-debian.repository_url
}

output "nginx_repository_url" {
  description = "Nginx Repository url"
  value       = aws_ecr_repository.aws-ecr-centos.repository_url
}

#output "nginx_repository_pw" {
#  description = "Nginx Repository PW"
#  value       = aws_ecr_repository.aws-ecr-centos.private
#}
