resource "aws_ecr_repository_policy" "aws-ecr-debian" {
  repository = aws_ecr_repository.aws-ecr-debian.name
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

resource "aws_ecr_repository_policy" "aws-ecr-centos" {
  repository = aws_ecr_repository.aws-ecr-centos.name
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


resource "aws_ecr_lifecycle_policy" "aws-ecr-debian" {
  repository = aws_ecr_repository.aws-ecr-debian.name
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

resource "aws_ecr_lifecycle_policy" "aws-ecr-centos" {
  repository = aws_ecr_repository.aws-ecr-centos.name
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


/*

data "aws_iam_policy_document" "ecr_repository_default" {
  version = "2008-10-17"

  statement {
    sid    = "AllowIAMDelegation"
    effect = "Allow"

    actions = [
      "*",
    ]

    principals {
      type = "AWS"

      identifiers = [
        "arn:aws:iam::${var.aws_account_id}:root",
      ]
    }
  }
}

*/
