output "ec2_instance_id" {
  description = "Instance ID"
  value       = aws_instance.ec2_instance.id
}

output "private_ip" {
  description = "private IP"
  value       = aws_instance.ec2_instance.private_ip
  #  value = try(aws_instance.webserver[0].private_ip, aws_spot_instance_request.webserver[0].private_ip, "")
}

output "public_ip" {
  description = "The public IP"
  value       = aws_instance.ec2_instance.public_ip
  #  value       = try(aws_instance.webserver[0].public_ip, aws_spot_instance_request.webserver[0].public_ip, "")
}
