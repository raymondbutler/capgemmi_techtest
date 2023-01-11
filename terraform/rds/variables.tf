variable "app_name" {}
variable "app_environment" {}
variable "availability_zones" {}
variable "vpc_id" {}
variable "private-subnets" {}
variable "rds_sg_id" {}
variable "tags" {
  type = map(any)
}
