output "rds_id" {
  description = "RDS ID"
  value       = aws_rds_cluster.rds_cluster.id
}

output "rds_master_password" {
  description = "SSM Parameter ID"
  value       = aws_ssm_parameter.SSMDatabaseMasterPassword.id
}
