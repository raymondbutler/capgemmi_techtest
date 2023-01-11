# required_version = "~> 0.12.0"

terraform {
  required_version = ">= 0.12.0, <= 0.12.6"
}

provider "aws" {
  region    = var.aws_region
  profile   = var.aws_profile
  allowed_account_ids = [
    var.aws_account_id,
    ]

  default_tags {
    tags = {
      builder     = "terraform-v1.3.5"
      project     = "capgemmi_techtest"
    }
  }
}
