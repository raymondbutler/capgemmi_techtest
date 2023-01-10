terraform {
  required_version = ">= 1.3.0, <= 1.3.5"
  required_providers {
    aws = {
      # hashicorp/aws v4.32.0
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
    local = {
      source = "hashicorp/local"
    }
  }
}

provider "aws" {
  region    = var.aws_region
  profile   = var.aws_profile
  allowed_account_ids = [
    var.aws_account_id,
    ]

  default_tags {
    tags = {
      Environment = "Production"
      builder     = "terraform-v1.3.5"
    }
  }
}
