terraform {
  required_version = "~>1.8.3"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.70.0"
    }
  }
}

provider "aws" {
  region = "ap-south-1"
}

module "vpc-module" {
  source                    = "./modules/vpc"
  vpc_cidr_block            = "192.168.0.0/24"
  instance_tenancy          = "default"
  vpc_name                  = "akshay-terraform-vpc"
  public_subnet_cidr_block  = "192.168.0.0/28"
  private_subnet_cidr_block = "192.168.0.48/28"
  availability_zones        = "ap-south-1a"
}

module "ec2-module" {
  source         = "./modules/ec2"
  vpc_id         = module.vpc-module.vpc-id
  instance_count = 2
  ami_id         = "ami-078264b8ba71bc45e"
  instance_type  = "t2.micro"
  subnet_ids     = [module.vpc-module.public-subnet-id, module.vpc-module.private-subnet-id]
  ssh_cidr_ip    = "162.10.228.144/32"
}

terraform {
  backend "s3" {
    bucket = "akshay-jenkins-task"
    key    = "akshay/terraform/task.tfstate"
    region = "ap-south-1"
  }
}