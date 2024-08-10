module "db-sg" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "5.1.2"

  name = "db-security-group"
  description = "Access to MySQL DB for entire VPC CIDR"
  vpc_id = module.vpc.vpc_id

  #ingress rule and CIDR 

  ingress_with_cidr_blocks = [
    {
      from_port   = 3306
      to_port     = 3306
      protocol    = "tcp"
      description = "MySQL access within VPC"
      cidr_blocks = module.vpc.vpc_cidr_block
    }
  ]

  #egress rule
  egress_rules = ["all-all"]
  tags = local.common_tags
}