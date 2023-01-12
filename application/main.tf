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

terraform {
  required_version = ">= 1.3.0, <= 1.3.5"
    required_providers {
      docker = {
        source = "kreuzwerker/docker"
#        source = "terraform-providers/docker"
        version = "2.23.1"
      }
    }
}

provider "docker" {}

resource "aws_secretsmanager_secret" "aws-ecr-secret" {
  name = "ecr-notejam_nodejs"
}

# WIP: Need to store the creds for the repo here!!
resource "aws_secretsmanager_secret_version" "aws-ecr-secret-value" {
  secret_id = aws_secretsmanager_secret.aws-ecr-secret.id
  secret_string = "Example String"
# value key pair example below
#  secret_string = <<EOF
#{
#  "username": "adminaccount",
#  "password": "testpassword"
#}
#EOF
}

resource "aws_ecr_repository" "aws-ecr-notejam_nodejs" {
  name                 = "notejam_nodejs"
  image_tag_mutability = "MUTABLE"
  tags = merge(
    var.tags,
    {
      "Name" = "ecr-notejam-nodejs"
    }
  )
}

resource "aws_ecr_repository_policy" "aws-ecr-notejam-policy" {
  repository = aws_ecr_repository.aws-ecr-notejam_nodejs.name
  policy = <<EOF
{
    "Version": "2008-10-17",
    "Statement": [
        {
            "Sid": "Allow Full Access",
            "Effect": "Allow",
            "Principal": {
              "AWS": "arn:aws:iam::${var.aws_account_id}:root"
            },
            "Action": [
                "ecr:GetDownloadUrlForLayer",
                "ecr:BatchGetImage",
                "ecr:BatchCheckLayerAvailability",
                "ecr:PutImage",
                "ecr:InitiateLayerUpload",
                "ecr:UploadLayerPart",
                "ecr:CompleteLayerUpload",
                "ecr:DescribeRepositories",
                "ecr:GetRepositoryPolicy",
                "ecr:ListImages",
                "ecr:DeleteRepository",
                "ecr:BatchDeleteImage",
                "ecr:SetRepositoryPolicy",
                "ecr:DeleteRepositoryPolicy"
            ]
        }
    ]
}
EOF
}

resource "aws_ecr_lifecycle_policy" "aws-ecr-notejam-lc-policy" {
  repository = aws_ecr_repository.aws-ecr-notejam_nodejs.name
  policy = <<EOF

{
  "rules": [
    {
      "rulePriority": 1,
      "description": "Expire untagged images older than 14 days",
      "selection": {
        "tagStatus": "untagged",
        "countType": "sinceImagePushed",
        "countUnit": "days",
        "countNumber": 14
      },
      "action": {
        "type": "expire"
      }
    },
    {
      "rulePriority": 2,
      "description": "Expire Keep last 30 images",
      "selection": {
        "tagStatus": "tagged",
        "tagPrefixList": ["THISISNOTAREALTAG"],
        "countType": "imageCountMoreThan",
        "countNumber": 30
      },
      "action": {
        "type": "expire"
      }
    }
  ]
}
EOF
}


resource "docker_image" "custom_nodejs_image" {
  name         = "notejam_nodejs:latest"
  keep_locally = true
  build {
    dockerfile = "Dockerfile"
    path       = "."
    remove     = true
    tag        = []
  }
}

resource "docker_container" "nodejs_notejam" {
  image                 = docker_image.custom_nodejs_image.name
  name                  = "notejam"
  domainname            = "server.local"
  restart               = "unless-stopped"
  destroy_grace_seconds = 30
  must_run              = true
  memory                = 256
  env                   = ["NAME=NOTEJAM", "PORT=80", "NODE_ENV=development"]
#  command = ["node", "/app/webserver.js"]
  command               = ["/app/bin/www"]

  ports {
    internal = 80
    external = 8082
    ip       = "0.0.0.0"
  }
}

output "nodejs_repository_url" {
  description = "NodeJS Repository url"
  value       = aws_ecr_repository.aws-ecr-notejam_nodejs.repository_url
}

