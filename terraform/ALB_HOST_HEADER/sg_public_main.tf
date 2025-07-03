module "public-bastion-sg" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "5.1.2"

  name = "public-security-group"
  description = "Security group allows public traffic from internet"
  vpc_id = module.vpc.vpc_id

  #ingress rule and CIDR 
  ingress_rules = ["ssh-tcp"]
  ingress_cidr_blocks = ["0.0.0.0/0"]

  #egress rule
  egress_rules = ["all-all"]
  tags = local.common_tags
}