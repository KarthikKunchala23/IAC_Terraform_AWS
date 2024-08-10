module "elb-sg" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "5.1.2"

  name = "elb-security-group"
  description = "Security group allows http traffic from internet"
  vpc_id = module.vpc.vpc_id

  #ingress rule and CIDR 
  ingress_rules = ["http-80-tcp", "https-443-tcp"]
  ingress_cidr_blocks = ["0.0.0.0/0"]

  ingress_with_cidr_blocks = [
    {
      from_port   = 81
      to_port     = 81
      protocol    = 6
      description = "Allow port 81 from internet"
      cidr_blocks = "0.0.0.0/0"
    }
  ]

  #egress rule
  egress_rules = ["all-all"]
  tags = local.common_tags
}