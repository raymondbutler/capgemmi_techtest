locals {
  bucket_name = "${var.aws_account_id}-tf-state"
}

resource "aws_s3_bucket" "terraform_state" {
  bucket = local.bucket_name
  force_destroy = false
  tags   = var.tags
}

resource "aws_s3_bucket_acl" "terraform_state" {
  bucket = local.bucket_name
  acl    = "private"
}

resource "aws_s3_bucket_public_access_block" "terraform_state" {
  bucket                  = local.bucket_name
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_policy" "terraform_state" {
  bucket = local.bucket_name
  policy = data.aws_iam_policy_document.terraform_state.json
}

resource "aws_s3_bucket_versioning" "terraform_state" {
  bucket = local.bucket_name
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "terraform_state" {
  bucket = local.bucket_name
    rule {
      apply_server_side_encryption_by_default {
      sse_algorithm     = "AES256"
    }
  }
}

data "aws_iam_policy_document" "terraform_state" {
  statement {
    principals {
      type        = "AWS"
      identifiers = ["${var.aws_account_id}"]
    }

    actions = [
      "s3:*"
    ]

    resources = [
      aws_s3_bucket.terraform_state.arn,
      "${aws_s3_bucket.terraform_state.arn}/*",
    ]
  }
}
