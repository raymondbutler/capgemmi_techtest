output "s3_bucket_arn" {
  description = "TF State bucket ARN"
  value = "${aws_s3_bucket.terraform_state.arn}"
}
