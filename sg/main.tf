resource "aws_security_group" "ec2" {
  name = "ops_service"
  description = "Ops Service Security Group"
  vpc_id      = var.vpc_id
  tags   = merge(
    var.tags,
    {
      "Name" = "Ops Service Security Group"
    }
  )

  ingress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["80.194.202.216/29"]
    description = "Raymond Butler - NOC"
  }

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allow All Outgoing"
  }
}

resource "aws_security_group" "ecs" {
  description = "Allow traffic for ECS"
  vpc_id = var.vpc_id

  ingress {
    from_port        = 0
    to_port          = 65535
    protocol         = "tcp"
#    cidr_blocks      = ["0.0.0.0/0"]
    cidr_blocks      = var.public_subnets
# not using IPV6
#    ipv6_cidr_blocks = ["::/0"]
  }

  ingress {
    from_port        = 0
    to_port          = 65535
    protocol         = "tcp"
#    cidr_blocks      = ["0.0.0.0/0"]
    cidr_blocks      = var.private_subnets
# not using IPV6
#    ipv6_cidr_blocks = ["::/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
# not using IPV6
#    ipv6_cidr_blocks = ["::/0"]
  }
  tags = merge(
    var.tags,
    {
      "Name" = "${var.app_name}-ecs"
    }
  )
}

resource "aws_security_group" "rds" {
  description = "Allow traffic for RDS Cluster"
  vpc_id = var.vpc_id

  ingress {
    from_port        = 3306
    to_port          = 3306
    protocol         = "tcp"
    cidr_blocks      = var.private_subnets
# not using IPV6
#    ipv6_cidr_blocks = ["::/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
# not using IPV6
#    ipv6_cidr_blocks = ["::/0"]
  }
  tags = merge(
    var.tags,
    {
      "Name" = "${var.app_name}-rds"
    }
  )
}

resource "aws_security_group" "alb" {
  description = "Allow traffic for ALB"
  vpc_id = var.vpc_id

  ingress {
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
#    ipv6_cidr_blocks = ["::/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
# not using IPV6
#    ipv6_cidr_blocks = ["::/0"]
  }
  tags = merge(
    var.tags,
    {
      "Name" = "${var.app_name}-alb"
    }
  )
}
