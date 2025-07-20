resource "aws_vpc" "main" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags = {
    Name = "eks-vpc"
  }
}

resource "aws_internet_gateway" "eks-igw" {
  vpc_id = aws_vpc.main.id
  tags = {
    Name = "eks-internet-gateway"
  }
}

resource "aws_subnet" "az1" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.az1_cidr_block
  availability_zone = var.az1_availability_zone
  map_public_ip_on_launch = true
  tags = {
    Name = "eks-public-subnet-az1"
    "kubernetes.io/role/elb" = "1"
    "kubernetes.io/cluster/${var.cluster_name}" = "shared"
  }
  
}

resource "aws_subnet" "az2" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.az2_cidr_block
  availability_zone = var.az2_availability_zone
  map_public_ip_on_launch = true
  tags = {
    Name = "eks-public-subnet-az2"
    "kubernetes.io/role/elb" = "1"
    "kubernetes.io/cluster/${var.cluster_name}" = "shared"
  }
  
}

resource "aws_subnet" "az3" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.az3_cidr_block
  availability_zone = var.az3_availability_zone
  tags = {
    Name = "eks-private-subnet-az3"
    "kubernetes.io/role/internal-elb" = "1"
    "kubernetes.io/cluster/${var.cluster_name}" = "shared"
  }
  
}

resource "aws_subnet" "az4" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.az4_cidr_block
  availability_zone = var.az4_availability_zone
  tags = {
    Name = "eks-private-subnet-az4"
    "kubernetes.io/role/internal-elb" = "1"
    "kubernetes.io/cluster/${var.cluster_name}" = "shared"
  }
  
}

# route table for public subnets
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id
  tags = {
    Name = "eks-public-route-table"
  }
  
}

resource "aws_route" "public_internet_route" {
  route_table_id         = aws_route_table.public.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.eks-igw.id
  
}

resource "aws_route_table_association" "public_az1" {
  subnet_id      = aws_subnet.az1.id
  route_table_id = aws_route_table.public.id
  
}

resource "aws_route_table_association" "public_az2" {
  subnet_id      = aws_subnet.az2.id
  route_table_id = aws_route_table.public.id
  
}

resource "aws_eip" "nat-eip" {
  domain = "vpc"
  tags = {
    Name = "eks-nat-eip"
  }
}

resource "aws_nat_gateway" "nat-gateway" {
  allocation_id = aws_eip.nat-eip.id
  subnet_id     = aws_subnet.az1.id
  tags = {
    Name = "eks-nat-gateway"
  }
  depends_on = [ aws_internet_gateway.eks-igw ]
}

# route table for private subnets
resource "aws_route_table" "private" {
  vpc_id = aws_vpc.main.id
  tags = {
    Name = "eks-private-route-table"
  }
  
}

resource "aws_route" "private_nat_route" {
  route_table_id         = aws_route_table.private.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.nat-gateway.id 
}

resource "aws_route_table_association" "private_az3" {
  subnet_id      = aws_subnet.az3.id
  route_table_id = aws_route_table.private.id
  
}

resource "aws_route_table_association" "private_az4" {
  subnet_id      = aws_subnet.az4.id
  route_table_id = aws_route_table.private.id
  
}