output "loadbalancer-address" {
    value = "${module.ecs-fargate.aws_lb_lb_dns_name}"
}