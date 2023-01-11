resource "aws_ecs_cluster" "nodejs-cluster" {
  name  = "nodejs-cluster"
  tags = merge(
    var.tags,
    {
      Name  = "nodejs-cluster"
    }
  )
}


/*
resource "aws_ecs_service" "nodejs" {
  name            = "nodejs"
  cluster         = aws_ecs_cluster.nodejs-cluster.id
  task_definition = aws_ecs_task_definition.aws-ecs-nodejs-task.arn
  desired_count   = 2
  tags = merge(
    var.tags,
    {
      Name  = "nodejs"
    }
  )
}


resource "aws_ecs_service" "nginx" {
  name            = "nginx"
  cluster         = aws_ecs_cluster.nginx-cluster.id
  task_definition = aws_ecs_task_definition.aws-ecs-nginx-task.arn
  desired_count   = 2
  tags = merge(
    var.tags,
    {
      Name  = "nginx"
    }
  )
}

*/


resource "aws_ecs_cluster" "nginx-cluster" {
  name  = "nginx-cluster"
  tags = merge(
    var.tags,
    {
      Name  = "nginx-cluster"
    }
  )
}



#data "template_file" "env_vars" {
#  template = file("./env_vars.json")
#}
#      "environment": ${data.template_file.env_vars.rendered},

resource "aws_ecs_task_definition" "aws-ecs-nodejs-task" {
  family = "nodejs-task"

  container_definitions = <<DEFINITION
  [
    {
      "name": "nodejs-${var.app_environment}-container",
      "image": "${var.nodejs_repository_url}:latest",
      "entryPoint": [],
      "environment": [
          {"name": "${var.app_environment}", "value": "nodejs"}
          ],
      "essential": true,
      "logConfiguration": {
        "logDriver": "awslogs",
        "options": {
          "awslogs-group": "${var.cloudwatch_nodejs_log}",
          "awslogs-region": "${var.aws_region}",
          "awslogs-stream-prefix": "nodejs-${var.app_environment}"
        }
      },
      "portMappings": [
        {
          "containerPort": 8080,
          "hostPort": 8080
        }
      ],
      "cpu": 256,
      "memory": 512,
      "networkMode": "awsvpc"
    }
  ]
  DEFINITION

  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  memory                   = "512"
  cpu                      = "256"
  execution_role_arn       = var.ecsTaskExecutionRole_arn
  task_role_arn            = var.ecsTaskExecutionRole_arn
  tags = merge(
    var.tags,
    {
      "Name" = "nodejs-ecs-td"
    }
  )
}

resource "aws_ecs_task_definition" "aws-ecs-nginx-task" {
  family = "nginx-task"

  container_definitions = <<DEFINITION
  [
    {
      "name": "nginx-${var.app_environment}-container",
      "image": "${var.nginx_repository_url}:latest",
      "entryPoint": [],
      "environment": [
          {"name": "${var.app_environment}", "value": "nginx"}
          ],
      "essential": true,
      "logConfiguration": {
        "logDriver": "awslogs",
        "options": {
          "awslogs-group": "${var.cloudwatch_nginx_log}",
          "awslogs-region": "${var.aws_region}",
          "awslogs-stream-prefix": "nginx-${var.app_environment}"
        }
      },
      "portMappings": [
        {
          "containerPort": 8080,
          "hostPort": 8080
        }
      ],
      "cpu": 256,
      "memory": 512,
      "networkMode": "awsvpc"
    }
  ]
  DEFINITION

  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  memory                   = "512"
  cpu                      = "256"
  execution_role_arn       = var.ecsTaskExecutionRole_arn
  task_role_arn            = var.ecsTaskExecutionRole_arn
  tags = merge(
    var.tags,
    {
      "Name" = "nginx-ecs-td"
    }
  )
}

data "aws_ecs_task_definition" "nodejs" {
  task_definition = aws_ecs_task_definition.aws-ecs-nodejs-task.family
}

data "aws_ecs_task_definition" "nginx" {
  task_definition = aws_ecs_task_definition.aws-ecs-nginx-task.family
}
