output "ecs_sg_id" {
  description = "ECS Security Group id"
  value = aws_security_group.ecs.id
}

output "alb_sg_id" {
  description = " ALB Security Group id"
  value = aws_security_group.alb.id
}
