module "alb" {
  source = "terraform-aws-modules/alb/aws"
  version = "9.9.0"

  name    = "${local.name}-alb"
  load_balancer_type = "application"
  vpc_id  = module.vpc.vpc_id
  subnets = module.vpc.public_subnets
  tags = local.common_tags

  # Security Group
  security_groups = [module.elb-sg.security_group_id]

#   access_logs = {
#     bucket = "my-alb-logs"
#   }

  target_groups = {
     app1 = {
       create_attachment = false  #To attach instance as target give this input as false and cretae aws_lb_target_group_attachment resource
       name_prefix                       = "app1-"
       protocol                          = "HTTP"
       port                              = 80
       target_type                       = "instance"
       deregistration_delay              = 10
       protocol_version = "HTTP1"
       load_balancing_cross_zone_enabled = false
       tags = local.common_tags
       health_check = {
         enabled             = true
         interval            = 30
         path                = "/app1/index.html"
         port                = "traffic-port"
         healthy_threshold   = 3
         unhealthy_threshold = 3
         timeout             = 6
         protocol            = "HTTP"
         matcher             = "200-399"
       }#END OF HEALTH CHECK BLOCK
     }#END OF TARGET GROUP BLOCK
  }#END OF TARGET GROUP

  listeners = {
    ex-https = {
      port            = 80
      protocol        = "HTTP"
    #   certificate_arn = "arn:aws:iam::123456789012:server-certificate/test_cert-123456789012"
      forward = {
        target_group_key = "app1"
      }
    }
  }#END OF LISTENER BLOCK

}

 resource "aws_lb_target_group_attachment" "app1" {
    for_each = {for k, v in module.ec2-instance-private: k => v}
    target_group_arn = module.alb.target_groups["app1"].arn
    target_id        = each.value.id
    port             = 80
}

output "ec2_alb_details" {
  value = {for ec2_instance, ec2_values in module.ec2-instance-private: ec2_instance => ec2_values}
}