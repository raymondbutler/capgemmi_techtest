# module "s3" {
#   source               = "./s3"
#   aws_account_id       = var.aws_account_id
#   tags                 = var.tags
# }

module "iam" {
  source               = "./iam"
  tags                 = var.tags
}

module "vpc" {
  source               = "./vpc"
  cidr                 = var.cidr
  public_subnets       = var.public_subnets
  private_subnets      = var.private_subnets
  availability_zones   = var.availability_zones
  tags                 = var.tags
}

module "sg" {
  source               = "./sg"
  app_name             = var.app_name
  app_environment      = var.app_environment
  vpc_id               = module.vpc.vpc_id
  public_subnets       = var.public_subnets
  private_subnets      = var.private_subnets
  tags                 = var.tags
}

module "ec2" {
  source               = "./ec2"
  app_name             = var.app_name
  app_environment      = var.app_environment
  vpc_id               = module.vpc.vpc_id
  private-subnets      = module.vpc.private-subnets
  public-subnets       = module.vpc.public-subnets
  ec2_sg_id            = module.sg.ec2_sg_id
  ssh_key_name         = var.ssh_key_name
  tags                 = var.tags
}


/*

module "rds" {
  source               = "./rds"
  app_name             = var.app_name
  app_environment      = var.app_environment
  availability_zones   = var.availability_zones
  vpc_id               = module.vpc.vpc_id
  private-subnets      = module.vpc.private-subnets
  rds_sg_id            = module.sg.rds_sg_id
  tags                 = var.tags
}


module "alb" {
  source               = "./alb"
  app_name             = var.app_name
  app_environment      = var.app_environment
  vpc_id               = module.vpc.vpc_id
  private-subnets      = module.vpc.private-subnets
  public-subnets       = module.vpc.public-subnets
  ecs_sg_id            = module.sg.ecs_sg_id
  alb_sg_id            = module.sg.alb_sg_id
  tags                 = var.tags
}

*/


/*


module "cloudwatch" {
  source               = "./cloudwatch"
  tags                 = var.tags
}

module "ecr" {
  source               = "./ecr"
  aws_account_id       = var.aws_account_id
  tags                 = var.tags
}

# /*

module "ecs" {
  source = "./ecs"
  aws_region           = var.aws_region
  app_name             = var.app_name
  app_environment      = var.app_environment
  nodejs_repository_url = module.ecr.nodejs_repository_url
  nginx_repository_url = module.ecr.nginx_repository_url
  cloudwatch_nodejs_log = module.cloudwatch.cloudwatch_nodejs_log
  cloudwatch_nginx_log  = module.cloudwatch.cloudwatch_nginx_log
  ecsTaskExecutionRole_arn  = module.iam.ecsTaskExecutionRole_arn
  tags                 = var.tags

#  environment          = "${var.environment}"
#  cluster              = "${var.environment}"
#  cloudwatch_prefix    = "${var.environment}"               #See ecs_instances module when to set this and when not!
#  vpc_cidr             = "${var.vpc_cidr}"
#  public_subnet_cidrs  = "${var.public_subnet_cidrs}"
#  private_subnet_cidrs = "${var.private_subnet_cidrs}"
#  availability_zones   = "${var.availability_zones}"
#  max_size             = "${var.max_size}"
#  min_size             = "${var.min_size}"
#  desired_capacity     = "${var.desired_capacity}"
#  key_name             = "${aws_key_pair.ecs-key.key_name}"
#  instance_type        = "${var.instance_type}"
#  ecs_aws_ami          = "${var.ecs_aws_ami}"
}

*/