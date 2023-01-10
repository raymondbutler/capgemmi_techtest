resource "aws_cloudwatch_log_group" "log-group-nodejs" {
  name                 = "nodejs-logs"
  tags = merge(
    var.tags,
    {
      "Name" = "nodejs-logs"
    }
  )
}

resource "aws_cloudwatch_log_group" "log-group-nginx" {
  name                 = "nginx-logs"
  tags = merge(
    var.tags,
    {
      "Name" = "nginx-logs"
    }
  )
}
