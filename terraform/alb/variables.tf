variable "app_name" {}
variable "app_environment" {}
variable "vpc_id" {}
variable "ecs_sg_id" {}
variable "alb_sg_id" {}
variable "private-subnets" {}
variable "public-subnets" {}
variable "tags" {
  type = map(any)
}
