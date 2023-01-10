# use different roles for execution_role_arn and task_role_arn (in order to follow least permissions principle)

resource "aws_iam_role" "ecsTaskExecutionRole" {
  name = "ecs-execution-task-role"
  description = "ECS Task Assume Role Policy"
  max_session_duration = "43200"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "ecs-tasks.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "ecsTaskExecutionRole_policy" {
  role       = aws_iam_role.ecsTaskExecutionRole.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEC2ContainerServiceforEC2Role"
}
