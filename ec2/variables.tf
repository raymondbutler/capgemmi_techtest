variable "app_name" {}
variable "app_environment" {}
variable "vpc_id" {}
variable "private-subnets" {}
variable "public-subnets" {}
variable "ec2_sg_id" {}
variable "ssh_key_name" {}
variable "tags" {
  type = map(any)
}
