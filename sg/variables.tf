variable "app_name" {}
variable "app_environment" {}
variable "vpc_id" {}
variable "private_subnets" {}
variable "public_subnets" {}
variable "tags" {
  type = map(any)
}
