output "vpc_id" {
  description = "VPC ID"
  value       = aws_vpc.vpc-1.id
}

output "private-subnets" {
  description = "Private Subnets"
  value = aws_subnet.subnet-private.*.id
}

output "public-subnets" {
  description = "Public Subnets"
  value = aws_subnet.subnet-public.*.id
}
