module "private-sg" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "5.1.2"

  name = "private-security-group"
  description = "Security group allows ssh & http traffic from  CIDR 10.0.0.0/16"
  vpc_id = module.vpc.vpc_id

  #ingress rule and CIDR 
  ingress_rules = ["ssh-22-tcp", "http-80-tcp"]
  ingress_cidr_blocks = [module.vpc.vpc_cidr_block]

  #egress rule
  egress_rules = ["all-all"]
  tags = local.common_tags
}