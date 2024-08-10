
# module "ec2-instance-private-app2" {  
#   depends_on = [ module.vpc ] #meta arrgument 
#   source  = "terraform-aws-modules/ec2-instance/aws"
#   version = "5.6.1"

#   name = "${local.name}-app2"
#   instance_type = var.instance_type
#   key_name = var.instance_keypair
#   ami = data.aws_ami.amazon-linux.id

#   for_each = toset(["0", "1"])
#   subnet_id = element(module.vpc.private_subnets, tonumber(each.key))
#   # element fun takes list and index and tonumber fun converts string to number

#   vpc_security_group_ids = [module.private-sg.security_group_id]
#   user_data = file("${path.module}/app2-install.sh")

#   tags = local.common_tags
# }