output "alb_dns_name" {
  description = "ALB DNS Name"
  value = aws_alb.application_load_balancer.dns_name
}
