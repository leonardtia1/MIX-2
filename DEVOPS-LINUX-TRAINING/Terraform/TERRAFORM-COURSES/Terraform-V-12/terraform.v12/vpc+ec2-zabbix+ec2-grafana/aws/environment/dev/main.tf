provider "aws" {
  region = "us-east-1"
}

#####
# Vpc
#####

module "vpc" {
  source = "../../modules/aws-vpc"

  vpc-location                        = "Virginia"
  namespace                           = "cloudgeeks.ca"
  name                                = "vpc"
  stage                               = "monitoring-dev"
  map_public_ip_on_launch             = "true"
  total-nat-gateway-required          = "1"
  create_database_subnet_group        = "false"
  vpc-cidr                            = "10.20.0.0/16"
  vpc-public-subnet-cidr              = ["10.20.1.0/24","10.20.2.0/24"]
  vpc-private-subnet-cidr             = ["10.20.4.0/24","10.20.5.0/24"]
  vpc-database_subnets-cidr           = ["10.20.7.0/24", "10.20.8.0/24"]
}


module "sg1" {
  source              = "../../modules/aws-sg-cidr"
  namespace           = "cloudgeeks.ca"
  stage               = "dev"
  name                = "monitoring"
  tcp_ports           = "22,80,443"
  cidrs               = ["0.0.0.0/0"]
  security_group_name = "monitoring"
  vpc_id              = module.vpc.vpc-id
}

module "sg2" {
  source                  = "../../modules/aws-sg-ref-v2"
  namespace               = "cloudgeeks.ca"
  stage                   = "dev"
  name                    = "monitoring-ref"
  tcp_ports               = "22,80,443"
  ref_security_groups_ids = [module.sg1.aws_security_group_default,module.sg1.aws_security_group_default,module.sg1.aws_security_group_default]
  security_group_name     = "zabbix-Ref"
  vpc_id                  = module.vpc.vpc-id
}

module "ec2-keypair" {
  source     = "../../modules/aws-ec2-keypair"
  key-name   = "monitoring"
  public-key = file("../../modules/secrets/monitoring.pub")

}


module "zabbix-eip" {
  source = "../../modules/eip/zabbix"
  name                         = "zabbix"
  instance                     = module.ec2-zabbix.id[0]
}

module "ec2-zabbix" {
  source                        = "../../modules/aws-ec2"
  namespace                     = "cloudgeeks.ca"
  stage                         = "dev"
  name                          = "zabbix"
  key_name                      = "monitoring"
  user_data                     = file("../../modules/aws-ec2/user-data/zabbix/user-data.sh")
  instance_count                = 1
  ami                           = "ami-0fc61db8544a617ed"
  instance_type                 = "t3a.medium"
  associate_public_ip_address   = "true"
  root_volume_size              = 20
  subnet_ids                    = module.vpc.public-subnet-ids
  vpc_security_group_ids        = [module.sg2.aws_security_group_default]

}

module "grafana-eip" {
  source = "../../modules/eip/zabbix"
  name                         = "grafana"
  instance                     = module.ec2-grafana.id[0]
}

module "ec2-grafana" {
  source                        = "../../modules/aws-ec2"
  namespace                     = "cloudgeeks.ca"
  stage                         = "dev"
  name                          = "grafana"
  key_name                      = "monitoring"
  user_data                     = file("../../modules/aws-ec2/user-data/grafana/user-data.sh")
  instance_count                = 1
  ami                           = "ami-0fc61db8544a617ed"
  instance_type                 = "t3a.medium"
  associate_public_ip_address   = "true"
  root_volume_size              = 20
  subnet_ids                    = module.vpc.public-subnet-ids
  vpc_security_group_ids        = [module.sg2.aws_security_group_default]

}


module "ec2-windows" {
  source                        = "../../modules/aws-ec2"
  namespace                     = "cloudgeeks.ca"
  stage                         = "dev"
  name                          = "windows"
  key_name                      = "monitoring"
  user_data                     = file("../../modules/aws-ec2/user-data/grafana/user-data.sh")
  instance_count                = 1
  ami                           = "ami-0f7122ac3de6f22b2"
  instance_type                 = "t3a.medium"
  associate_public_ip_address   = "true"
  root_volume_size              = 40
  subnet_ids                    = module.vpc.public-subnet-ids
  vpc_security_group_ids        = [module.sg2.aws_security_group_default]

}