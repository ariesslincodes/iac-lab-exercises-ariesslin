# import {
#   to = aws_subnet.vpc_plus
#   id = "subnet-01fbf97d6300a1c87"
# }

# moved {
#   from = aws_subnet.vpc_plus
#   to   = aws_subnet.private_subnet_3
# }

# resource "aws_subnet" "vpc_plus" {
#   vpc_id = aws_vpc.vpc.id

#   cidr_block = "192.168.1.96/28"

#   tags = {
#     Name = "ariesslin-subnet-plus"
#   }
# }

# resource "aws_subnet" "private_subnet_3" {
#   vpc_id                  = aws_vpc.vpc.id
#   cidr_block              = "192.168.1.96/28"
#   availability_zone       = format("%sb", var.region)
#   map_public_ip_on_launch = "false"

#   tags = {
#     Name = format("%s-private-subnet-3", var.prefix)
#   }
# }

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

resource "aws_eip" "nat" {
  domain = "vpc"

  tags = {
    Name = format("%s-eip", var.prefix)
  }
}

resource "aws_nat_gateway" "ngw" {
  allocation_id = aws_eip.nat.id
  subnet_id     = aws_subnet.public_subnet_1.id

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
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.ngw.id
  }

  tags = {
    Name = format("%s-route-table-for-private-subnet", var.prefix)
  }
}

resource "aws_route_table_association" "public_subnet_1" {
  subnet_id      = aws_subnet.public_subnet_1.id
  route_table_id = aws_route_table.public_route.id
}

resource "aws_route_table_association" "public_subnet_2" {
  subnet_id      = aws_subnet.public_subnet_2.id
  route_table_id = aws_route_table.public_route.id
}

resource "aws_route_table_association" "private_subnet_1" {
  subnet_id      = aws_subnet.private_subnet_1.id
  route_table_id = aws_route_table.private_route.id
}

resource "aws_route_table_association" "private_subnet_2" {
  subnet_id      = aws_subnet.private_subnet_2.id
  route_table_id = aws_route_table.private_route.id
}
