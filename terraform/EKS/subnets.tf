resource "aws_vpc" "main" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags = {
    Name = "eks-vpc"
  }
}



resource "aws_subnet" "az1" {
  vpc_id            = var.vpc_id
  cidr_block        = var.az1_cidr_block
  availability_zone = var.az1_availability_zone
  tags = {
    Name = "eks-subnet-az1"
  }
  
}

resource "aws_subnet" "az2" {
  vpc_id            = var.vpc_id
  cidr_block        = var.az2_cidr_block
  availability_zone = var.az2_availability_zone
  tags = {
    Name = "eks-subnet-az2"
  }
  
}

resource "aws_subnet" "az3" {
  vpc_id            = var.vpc_id
  cidr_block        = var.az3_cidr_block
  availability_zone = var.az3_availability_zone
  tags = {
    Name = "eks-subnet-az3"
  }
  
}
