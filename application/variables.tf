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
