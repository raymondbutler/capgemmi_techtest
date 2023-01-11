variable "app_name" {}
variable "app_environment" {}
variable "nodejs_repository_url" {}
variable "nginx_repository_url" {}
variable "cloudwatch_nodejs_log" {}
variable "cloudwatch_nginx_log" {}
variable "aws_region" {}
variable "ecsTaskExecutionRole_arn" {}
variable "tags" {
  type = map(any)
}
