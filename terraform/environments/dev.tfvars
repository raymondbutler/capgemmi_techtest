aws_account_id     = "329803241466"
aws_region         = "eu-west-1"
aws_profile        = "iSYSUK-SANDBOX"

availability_zones = ["eu-west-1a", "eu-west-1b", "eu-west-1c"]

cidr               = "10.0.0.0/16"
public_subnets     = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
private_subnets    = ["10.0.11.0/24", "10.0.12.0/24", "10.0.13.0/24"]

app_name           = "notejam"
app_environment    = "dev"

domain_name        = "dev.local"
ssh_key_name       = "dev_ec2_ssh_key"
