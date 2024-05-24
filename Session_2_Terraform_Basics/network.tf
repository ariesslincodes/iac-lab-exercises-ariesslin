resource "aws_vpc" "vpc" {
  cidr_block           = var.vpc_cidr
  enable_dns_support   = "true"
  enable_dns_hostnames = "true"
  instance_tenancy     = "default"

  tags = {
    Name = format("%s-vpc", var.prefix)
  }
}

resource "aws_subnet" "public_subnet_1" {
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = var.subnet1_cidr
  availability_zone       = format("%sa", var.region)
  map_public_ip_on_launch = "true"

  tags = {
    Name = format("%s-public-subnet-1", var.prefix)
  }
}

resource "aws_subnet" "public_subnet_2" {
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = var.subnet2_cidr
  availability_zone       = format("%sb", var.region)
  map_public_ip_on_launch = "true"

  tags = {
    Name = format("%s-public-subnet-2", var.prefix)
  }
}

resource "aws_subnet" "private_subnet_1" {
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = var.subnet3_cidr
  availability_zone       = format("%sa", var.region)
  map_public_ip_on_launch = "false"

  tags = {
    Name = format("%s-private-subnet-1", var.prefix)
  }
}

resource "aws_subnet" "private_subnet_2" {
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = var.subnet4_cidr
  availability_zone       = format("%sb", var.region)
  map_public_ip_on_launch = "false"

  tags = {
    Name = format("%s-private-subnet-2", var.prefix)
  }
}

resource "aws_subnet" "secure_subnet_1" {
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = var.subnet5_cidr
  availability_zone       = format("%sa", var.region)
  map_public_ip_on_launch = "false"

  tags = {
    Name = format("%s-secure-subnet-1", var.prefix)
  }
}

resource "aws_subnet" "secure_subnet_2" {
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = var.subnet6_cidr
  availability_zone       = format("%sb", var.region)
  map_public_ip_on_launch = "false"

  tags = {
    Name = format("%s-secure-subnet-2", var.prefix)
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = format("%s-gw", var.prefix)
  }
}

resource "aws_eip" "ngw_for_subnet_1" {
  domain = "vpc"

  tags = {
    Name = format("%s-eip", var.prefix)
  }
}

resource "aws_nat_gateway" "ngw" {
  allocation_id = aws_eip.ngw_for_subnet_1.id
  subnet_id     = aws_subnet.private_subnet_1.id

  tags = {
    Name = format("%s-ngw", var.prefix)
  }
}

resource "aws_route_table" "public_route" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = format("%s-route-table-for-public-subnet", var.prefix)
  }
}

resource "aws_route_table" "private_route" {
  vpc_id = aws_vpc.vpc.id

  route {
    ipv6_cidr_block = "0.0.0.0/0"
    nat_gateway_id  = aws_nat_gateway.ngw.id
  }

  tags = {
    Name = format("%s-route-table-for-private-subnet", var.prefix)
  }
}