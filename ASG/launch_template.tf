resource "aws_launch_template" "launch_template1" {
  name = "launch-template1"
  description = "launch template for ec2 servers for applictaions"
  image_id = data.aws_ami.amazon-linux.id
  instance_type = var.instance_type

  vpc_security_group_ids = [ module.private-sg.security_group_id]
  key_name = var.instance_keypair
  user_data = filebase64("${path.module}/app1-install.sh")
  ebs_optimized = true
#   default_version = 1
  update_default_version = true
  block_device_mappings {
    device_name = "/dev/sda1"
    ebs {
      volume_size = 10
      delete_on_termination = true
      volume_type = "gp2"
    }
  }
  monitoring {
    enabled = true
  }
  tag_specifications {
    resource_type = "instance"

    tags = {
        Name = "asg-app1"
    }
  }
}

# resource "aws_launch_template" "launch_template2" {
#   name = "launch-template2"
#   description = "launch template for ec2 servers for applictaions"
#   image_id = data.aws_ami.amazon-linux.id
#   instance_type = var.instance_type

#   vpc_security_group_ids = [ module.private-sg.security_group_id]
#   key_name = var.instance_keypair
#   user_data = filebase64("${path.module}/app2-install.sh")
#   ebs_optimized = true
# #   default_version = 1
#   update_default_version = true
#   block_device_mappings {
#     device_name = "/dev/sda1"
#     ebs {
#       volume_size = 10
#       delete_on_termination = true
#       volume_type = "gp2"
#     }
#   }
#   monitoring {
#     enabled = true
#   }
#   tag_specifications {
#     resource_type = "instance"

#     tags = {
#         Name = "asg-app2"
#     }
#   }
# }

# resource "aws_launch_template" "launch_template3" {
#   name = "launch-template3"
#   description = "launch template for ec2 servers for applictaions"
#   image_id = data.aws_ami.amazon-linux.id
#   instance_type = var.instance_type

#   vpc_security_group_ids = [ module.private-sg.security_group_id]
#   key_name = var.instance_keypair
#   user_data = filebase64(templatefile("app3-install.tmpl",{rds_db_endpoint = module.db.db_instance_address, rds_db_password = var.db_password }))
#   ebs_optimized = true
# #   default_version = 1
#   update_default_version = true
#   block_device_mappings {
#     device_name = "/dev/sda1"
#     ebs {
#       volume_size = 10
#       delete_on_termination = true
#       volume_type = "gp2"
#     }
#   }
#   monitoring {
#     enabled = true
#   }
#   tag_specifications {
#     resource_type = "instance"

#     tags = {
#         Name = "asg-app3"
#     }
#   }
# }