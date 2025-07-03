
module "ec2-instance-public" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "5.6.1"

  name = "${local.name}-public"
  instance_type = var.instance_type
  key_name = var.instance_keypair
  ami = data.aws_ami.amazon-linux.id
  subnet_id = module.vpc.public_subnets[0]
  vpc_security_group_ids = [module.public-bastion-sg.security_group_id]

  tags = local.common_tags
}