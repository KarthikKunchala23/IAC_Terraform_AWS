#public sg outputs
output "public_security_group_arn" {
  description = "The ARN of the security group"
  value       = module.public-bastion-sg.security_group_arn
}

output "public_security_group_id" {
  description = "The ID of the security group"
  value       = module.public-bastion-sg.security_group_id
}

output "public_security_group_vpc_id" {
  description = "The VPC ID"
  value       = module.public-bastion-sg.security_group_vpc_id
}

output "public_security_group_name" {
  description = "The name of the security group"
  value       = module.public-bastion-sg.security_group_name
}


#private sg outputs
output "private_security_group_arn" {
  description = "The ARN of the security group"
  value       = module.private-sg.security_group_arn
}

output "private_security_group_id" {
  description = "The ID of the security group"
  value       = module.private-sg.security_group_id
}

output "private_security_group_vpc_id" {
  description = "The VPC ID"
  value       = module.private-sg.security_group_vpc_id
}

output "private_security_group_name" {
  description = "The name of the security group"
  value       = module.private-sg.security_group_name
}