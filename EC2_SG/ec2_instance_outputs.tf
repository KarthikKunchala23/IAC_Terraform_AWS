output "public_instance_id" {
  description = "public ec2 instance id"
  value = module.ec2-instance-public.id
}

output "public_instance_ip" {
  description = "public ip of bastion public ec2"
  value = module.ec2-instance-public.public_ip
}

output "private_instance_id" {
  description = "private instance id's"
  value = [for ec2private in module.ec2-instance-private: ec2private.id]
}

output "private_ip" {
  description = "private ip's of private ec2 instances"
  value = [for ec2private in module.ec2-instance-private: ec2private.private_ip]
}