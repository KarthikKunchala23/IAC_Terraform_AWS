#create VPC Terraform Module
module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "5.8.1"

  #VPC Basic Details
  name = "${local.name}-${var.vpc_name}"
  cidr = var.cidr_block

  azs = var.vpc_az
  private_subnets =var.vpc_private_subnets
  public_subnets = var.vpc_public_subnets

  #Database subnets
  create_database_subnet_group = var.vpc_create_database_subnet_group
  create_database_subnet_route_table = var.vpc_create_database_subnte_group_route_table

  database_subnets = var.vpc_database_subnets

#   create_database_internet_gateway_route = true
#   create_database_nat_gateway_route = true

   # Nat gateway for outbound
   enable_nat_gateway = var.vpc_enable_nat_gateway
   single_nat_gateway = var.vpc_single_nat_gateway

   #vpc DNS parameter
   enable_dns_hostnames = true
   enable_dns_support = true

   public_subnet_tags = {
    type = "public_subnet"
   }

   private_subnet_tags = {
    type = "private_subnet"
   }

   database_subnet_tags = {
    type = "database_subnet"
   }

   tags = local.common_tags

   vpc_tags = local.common_tags
}