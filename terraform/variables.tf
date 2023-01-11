variable "aws_account_id" {
  type        = string
  description = "AWS Account Number"
}

variable "aws_region" {
  type        = string
  description = "AWS Region"
}

variable "aws_profile" {
  type        = string
  description = "AWS Account Profile"
}

variable "tags" {
  description = "A map of tags to add to all resources"
  type        = map(any)
  default = {
    "team"           = "Platform"
    "configuration"  = "Capgemini-techtest"
  }
}

variable "aws_cloudwatch_retention_in_days" {
  type        = number
  description = "AWS CloudWatch Logs Retention in Days"
  default     = 1
}

variable "app_name" {
  type        = string
  description = "Application Name"
}

variable "app_environment" {
  type        = string
  description = "Application Environment"
}

variable "cidr" {
  description = "The CIDR block for the VPC."
}

variable "public_subnets" {
  description = "List of public subnets"
}

variable "private_subnets" {
  description = "List of private subnets"
}

variable "availability_zones" {
  description = "List of availability zones"
}

variable "domain_name" {
  type        = string
  description = "This is the default domain parent"
}

variable "ssh_key_name" {
  type        = string
  description = "The EC2 instance SSH key name"
}
