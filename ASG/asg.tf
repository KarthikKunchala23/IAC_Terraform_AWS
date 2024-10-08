resource "aws_autoscaling_group" "asg-app1" {
  name_prefix = "app1-asg-"
  desired_capacity = 2
  max_size = 10
  min_size = 2
  vpc_zone_identifier = module.vpc.private_subnets
  target_group_arns = [module.alb.target_groups["mytg1"].arn]
  health_check_type = "EC2"

  launch_template {
    id = aws_launch_template.launch_template1.id
    version = aws_launch_template.launch_template1.latest_version
  }
  
  instance_refresh {
    strategy = "Rolling"
    preferences {
      min_healthy_percentage = 50
    }
    triggers = ["desired_capacity"]
  }
  tag {
    key                 = "Owners"
    value               = "Web-Team"
    propagate_at_launch = true
  }
}

# resource "aws_autoscaling_group" "asg-app2" {
#   name_prefix = "app2-asg-"
#   desired_capacity = 2
#   max_size = 10
#   min_size = 2
#   vpc_zone_identifier = module.vpc.private_subnets
#   target_group_arns = [module.alb.target_groups["mytg2"].arn]
#   health_check_type = "EC2"

#   launch_template {
#     id = aws_launch_template.launch_template2.id
#     version = aws_launch_template.launch_template2.latest_version
#   }
  
#   instance_refresh {
#     strategy = "Rolling"
#     preferences {
#       min_healthy_percentage = 50
#     }
#     triggers = ["desired_capacity"]
#   }
#   tag {
#     key                 = "Owners"
#     value               = "Web-Team"
#     propagate_at_launch = true
#   }
# }

# resource "aws_autoscaling_group" "asg-app3" {
#   name_prefix = "app3-asg-"
#   desired_capacity = 2
#   max_size = 10
#   min_size = 2
#   vpc_zone_identifier = module.vpc.private_subnets
#   target_group_arns = [module.alb.target_groups["mytg3"].arn]
#   health_check_type = "EC2"

#   launch_template {
#     id = aws_launch_template.launch_template3.id
#     version = aws_launch_template.launch_template3.latest_version
#   }
  
#   instance_refresh {
#     strategy = "Rolling"
#     preferences {
#       min_healthy_percentage = 50
#     }
#     triggers = ["desired_capacity"]
#   }
#   tag {
#     key                 = "Owners"
#     value               = "Web-Team"
#     propagate_at_launch = true
#   }
# }