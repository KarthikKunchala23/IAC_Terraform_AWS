resource "aws_eip" "elastic_ip" {
  depends_on = [ 
    module.vpc,
    module.ec2-instance-public
   ]
   domain = "vpc"
   instance = module.ec2-instance-public.id

   tags = local.common_tags
}