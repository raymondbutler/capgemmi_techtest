resource "random_password" "DatabaseMasterPassword" {
  length           = 24
  lower            = true
  upper            = true
  numeric          = true
  special          = true
  override_special = "!#$%^*()-=+_?{}|"
}

resource "aws_ssm_parameter" "SSMDatabaseMasterPassword" {
  name  = "database-master-password"
  type  = "SecureString"
  value = random_password.DatabaseMasterPassword.result
}


resource "aws_db_subnet_group" "rds_subnet_group" {
  name       = "${var.app_name}-${var.app_environment}-subnet-group"
  subnet_ids = var.private-subnets
  tags = merge(
    var.tags,
    {
      "Name" = "DB-Subnet-Group"
    }
  )
}

resource "aws_rds_cluster" "rds_cluster" {
  cluster_identifier      = "${var.app_name}-${var.app_environment}-rds"
  engine                  = "aurora-mysql"  
  engine_mode             = "serverless"  
  database_name           = var.app_name
  enable_http_endpoint    = true  
  availability_zones      = var.availability_zones
  vpc_security_group_ids  = [var.rds_sg_id]
  db_subnet_group_name    = aws_db_subnet_group.rds_subnet_group.name
  master_username         = "root"
  master_password = random_password.DatabaseMasterPassword.result
  backup_retention_period = 1
  preferred_backup_window = "02:15-04:30"
  skip_final_snapshot     = true

  scaling_configuration {
    auto_pause               = true
    min_capacity             = 1    
    max_capacity             = 2
    seconds_until_auto_pause = 300
    timeout_action           = "ForceApplyCapacityChange"
  }

  tags = merge(
    var.tags,
    {
      "Name" = "${var.app_name}-${var.app_environment}-rds"
    }
  )
}
