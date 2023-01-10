resource "aws_instance" "ec2_instance" {
  ami                             = "ami-0ea0f26a6d50850c5"
  instance_type                   = "t2.micro"
  associate_public_ip_address     = "true"
  subnet_id                       = var.private-subnets[1]
  vpc_security_group_ids          = [var.ec2_sg_id]
  key_name                        = var.ssh_key_name
  tags   = merge(
    var.tags,
    {
      "Name" = "${var.app_name}-${var.app_environment}-ec2"
    }
  )

  #root_block_device {
  #  volume_size = 5
  #  volume_type = "gp3"
  #  encrypted   = true
  #  kms_key_id  = data.aws_kms_key.customer_master_key.arn
  #}


  user_data = <<EOF
#!/bin/bash -xe
exec > >(tee /var/log/user-data.log|logger -t user-data -s 2>/dev/console) 2>&1
sudo yum update -y
sudo yum install mc -y
EOF
}

resource "tls_private_key" "private_ssh_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "public_ssh_key" {
  key_name   = var.ssh_key_name
  public_key = tls_private_key.private_ssh_key.public_key_openssh
}

resource "local_file" "ssh_key" {
  filename             = "ssh_keys/${aws_key_pair.public_ssh_key.key_name}.pem"
  content              = tls_private_key.private_ssh_key.private_key_pem
  directory_permission = 0700
  file_permission      = 0400
}
