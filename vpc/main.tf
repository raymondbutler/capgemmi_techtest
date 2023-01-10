resource "aws_vpc" "vpc-1" {
  cidr_block           = var.cidr
  instance_tenancy     = "default"
  enable_nat_gateway   = true
  single_nat_gateway   = true
  enable_dns_support   = "true"
  enable_dns_hostnames = "true"

  tags = merge(
    var.tags,
    {
      "Name" = "VPC-1"
    }
  )
}

resource "aws_subnet" "subnet-public" {
  vpc_id                  = aws_vpc.vpc-1.id
  count                   = length(var.public_subnets)
  cidr_block              = element(var.public_subnets, count.index)
  availability_zone = element(var.availability_zones, count.index)
  map_public_ip_on_launch = "true"
  tags = merge(
    var.tags,
    {
      "Name" = "PUBLIC-SUBNETS"
    }
  )
}

resource "aws_subnet" "subnet-private" {
  vpc_id                  = aws_vpc.vpc-1.id
  count                   = length(var.private_subnets)
  cidr_block              = element(var.private_subnets, count.index)
  availability_zone = element(var.availability_zones, count.index)
  map_public_ip_on_launch = false
  tags = merge(
    var.tags,
    {
      "Name" = "PRIVATE-SUBNETS"
    }
  )
}


#################################



/*
resource "aws_default_network_acl" "default" {
  default_network_acl_id = aws_vpc.vpc-1.default_network_acl_id
  subnet_ids             = var.public_subnets
  ingress {
    protocol   = -1
    rule_no    = 100
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 0
    to_port    = 0
  }

  egress {
    protocol   = -1
    rule_no    = 100
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 0
    to_port    = 0
  }
  tags = merge(
    var.tags,
    {
      "Name" = "DEFAULT-ALC"
    }
  )

  depends_on  = [
    aws_vpc.vpc-1,
    aws_subnet.subnet-private,
    aws_subnet.subnet-public,
  ]
}
*/


##################################


resource "aws_internet_gateway" "igw-1" {
  vpc_id = aws_vpc.vpc-1.id
  tags = merge(
    var.tags,
    {
      "Name" = "IGW-1"
    }
  )
}

resource "aws_default_route_table" "default_route" {
  #  vpc_id = "${aws_vpc.vpc-1.id}"
  default_route_table_id = aws_vpc.vpc-1.default_route_table_id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw-1.id
  }
  tags = merge(
    var.tags,
    {
      "Name" = "default table"
    }
  )
}
