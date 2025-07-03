variable "aws_region" {
  type = string
  default = "us-east-1"
}

variable "environment" {
  description = "Environment"
  type = string
  default = "dev"
}

variable "bussiness_team" {
  description = "bussiness team"
  type = string
  default = "Admin"
  
}

variable "vpc_name" {
  description = "name of the vpc"
  type = string
  default = "booking-app-vpc"
}

variable "cidr_block" {
  description = "CIDR block for vpc"
  type = string
  default = "10.0.0.0/16"
}

variable "vpc_az" {
  description = "Availability zones for vpc"
  type = list(string)
  default = ["us-east-1a", "us-east-1b"]
}

variable "vpc_private_subnets" {
  description = "private subnets for vpc"
  type = list(string)
  default = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "vpc_public_subnets" {
  description = "public subntes for vpc"
  type = list(string)
  default = ["10.0.101.0/24", "10.0.102.0/24"]
}

variable "vpc_database_subnets" {
  description = "database subnets for vpc"
  type = list(string)
  default = ["10.0.151.0/24", "10.0.152.0/24"]
}

variable "vpc_create_database_subnet_group" {
  description = "VPC create database subnet group"
  type = bool
  default = true
}

variable "vpc_create_database_subnte_group_route_table" {
  description = "VPC create databse subnte route table"
  type = bool
  default = true
}

variable "vpc_enable_nat_gateway" {
  description = "Enable nat gateway for vpc"
  type = bool
  default = true
}

variable "vpc_single_nat_gateway" {
  description = "enable only single nat geateway in one AZ to save costs"
  type = bool
  default = true
}