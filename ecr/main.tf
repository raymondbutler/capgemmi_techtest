resource "aws_ecr_repository" "aws-ecr-debian" {
  name                 = "images/debian"
  image_tag_mutability = "MUTABLE"
  tags = merge(
    var.tags,
    {
      "Name" = "ecr-debian"
    }
  )
}

resource "aws_ecr_repository" "aws-ecr-centos" {
  name                 = "images/centos"
  image_tag_mutability = "MUTABLE"
  tags = merge(
    var.tags,
    {
      "Name" = "ecr-centos"
    }
  )
}
