# Launch Template Outputs
## launch_template_id
output "launch_template_id_app1" {
  description = "Launch Template ID"
  value = aws_launch_template.launch_template1.id 
}
## launch_template_latest_version
output "launch_template_latest_version_app1" {
  description = "Launch Template Latest Version"
  value = aws_launch_template.launch_template1.latest_version 
}

# output "launch_template_id_app2" {
#   description = "Launch Template ID"
#   value = aws_launch_template.launch_template2.id 
# }
# ## launch_template_latest_version
# output "launch_template_latest_version_app2" {
#   description = "Launch Template Latest Version"
#   value = aws_launch_template.launch_template1.latest_version 
# }

# output "launch_template_id_app3" {
#   description = "Launch Template ID"
#   value = aws_launch_template.launch_template3.id 
# }
# ## launch_template_latest_version
# output "launch_template_latest_version_app3" {
#   description = "Launch Template Latest Version"
#   value = aws_launch_template.launch_template3.latest_version 
# }




# Autoscaling Outputs
## autoscaling_group_id
output "autoscaling_group_id_app1" {
  description = "Autoscaling Group ID"
  value = aws_autoscaling_group.asg-app1.id 
}

## autoscaling_group_name
output "autoscaling_group_name_app1" {
  description = "Autoscaling Group Name"
  value = aws_autoscaling_group.asg-app1.name 
}
## autoscaling_group_arn
output "autoscaling_group_arn_app1" {
  description = "Autoscaling Group ARN"
  value = aws_autoscaling_group.asg-app1.arn 
}

# output "autoscaling_group_id_app2" {
#   description = "Autoscaling Group ID"
#   value = aws_autoscaling_group.asg-app2.id 
# }

# ## autoscaling_group_name
# output "autoscaling_group_name_app2" {
#   description = "Autoscaling Group Name"
#   value = aws_autoscaling_group.asg-app2.name 
# }
# ## autoscaling_group_arn
# output "autoscaling_group_arn_app2" {
#   description = "Autoscaling Group ARN"
#   value = aws_autoscaling_group.asg-app2.arn 
# }


# output "autoscaling_group_id_app3" {
#   description = "Autoscaling Group ID"
#   value = aws_autoscaling_group.asg-app3.id 
# }

# ## autoscaling_group_name
# output "autoscaling_group_name_app3" {
#   description = "Autoscaling Group Name"
#   value = aws_autoscaling_group.asg-app3.name 
# }
# ## autoscaling_group_arn
# output "autoscaling_group_arn_app3" {
#   description = "Autoscaling Group ARN"
#   value = aws_autoscaling_group.asg-app3.arn 
# }