#bastion public instance outputs
output "public_instance_id" {
  description = "public ec2 instance id"
  value = module.ec2-instance-public.id
}

output "public_instance_ip" {
  description = "public ip of bastion public ec2"
  value = module.ec2-instance-public.public_ip
}
#app1 instance outputs
# output "app1_private_instance_id" {
#   description = "private instance id's"
#   value = [for ec2private in module.ec2-instance-private-app1: ec2private.id]
# }

# output "app1_instance_private_ip" {
#   description = "private ip's of private ec2 instances"
#   value = [for ec2private in module.ec2-instance-private-app1: ec2private.private_ip]
# }

# #app2 instance outputs
# output "app2_private_instance_id" {
#   description = "private instance id's"
#   value = [for ec2private in module.ec2-instance-private-app2: ec2private.id]
# }

# output "app2_instance_private_ip" {
#   description = "private ip's of private ec2 instances"
#   value = [for ec2private in module.ec2-instance-private-app2: ec2private.private_ip]
# }

# #app3 instance outputs
# output "app3__private_instance_id" {
#   description = "list of app3 instance id's"
#   value = [for ec2private in module.ec2-instance-private-app3: ec2private.id]
# }

# output "app3_ec2_private_ip" {
#   description = "private ip's of app3 instances"
#   value = [for ec2private in module.ec2-instance-private-app3: ec2private.private_ip]
# }