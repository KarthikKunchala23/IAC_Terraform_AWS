variable "instance_type" {
  description = "instance type"
  type = string
  default = "t3.micro"
}

variable "instance_keypair" {
  description = "ec2 instance key pair"
  type = string
  default = "demo_key"
}

variable "private_instance_count" {
  description = "Number of ec2 instances"
  type = number
  default = 2
}