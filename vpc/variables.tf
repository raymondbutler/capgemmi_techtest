variable "cidr" {}
variable "public_subnets" {}
variable "private_subnets" {}
variable "availability_zones" {}
variable "tags" {
  type = map(any)
}
