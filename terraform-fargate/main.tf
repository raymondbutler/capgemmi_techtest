module "base-network" {
  source                                      = "cn-terraform/networking/aws"
  version                                     = "2.0.7"
  name_preffix                                = "${var.app_name}-${var.app_environment}"
  vpc_cidr_block                              = var.cidr
  availability_zones                          = var.availability_zones
  public_subnets_cidrs_per_availability_zone  = var.public_subnets
  private_subnets_cidrs_per_availability_zone = var.private_subnets
}

module "ecs-fargate" {
  source  = "cn-terraform/ecs-fargate/aws"
  version = "2.0.17"
  name_preffix        = "${var.app_name}-${var.app_environment}"
  vpc_id              = module.base-network.vpc_id
# To use a private repo it defaults to docker"
#  mount_points           = "repo_url"
  repository_credentials = "arn:aws:secretsmanager:eu-west-1:329803241466:secret:ecr-notejam_nodejs-Yw70y3"
  container_image     = "329803241466.dkr.ecr.eu-west-1.amazonaws.com/notejam_nodejs:latest"
#works  container_image     = "nginx"
# image     = "${aws_ecr_repository.hello_world.repository_url}:${var.release_version}"
  container_name      = var.app_name
  public_subnets_ids  = module.base-network.public_subnets_ids
  private_subnets_ids = module.base-network.private_subnets_ids
  lb_enable_https = false
}
