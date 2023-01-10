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
