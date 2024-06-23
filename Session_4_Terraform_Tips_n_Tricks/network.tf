resource "aws_vpc" "vpc" {
  cidr_block           = var.vpc_cidr
  enable_dns_support   = "true"
  enable_dns_hostnames = "true"
  instance_tenancy     = "default"

  tags = {
    Name = format("%s-vpc", var.prefix)
  }
}

resource "aws_subnet" "subnets" {
  count                   = 6
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = cidrsubnet("192.168.1.0/25", 3, count.index + 1)
  availability_zone       = format("%s%s", var.region, count.index % 2 == 0 ? "a" : "b")
  map_public_ip_on_launch = count.index < 2 ? "true" : "false"


  tags = {
    Name = format("%s-%s-subnet-%s", var.prefix, count.index < 2 ? "public" : count.index < 4 ? "private" : "secure", count.index % 2 == 0 ? 1 : 2)
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
  subnet_id     = [for key, subnet in aws_subnet.subnets : subnet.id][0]

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
  subnet_id      = [for key, subnet in aws_subnet.subnets : subnet.id][0]
  route_table_id = aws_route_table.public_route.id
}

resource "aws_route_table_association" "public_subnet_2" {
  subnet_id      = [for key, subnet in aws_subnet.subnets : subnet.id][1]
  route_table_id = aws_route_table.public_route.id
}

resource "aws_route_table_association" "private_subnet_1" {
  subnet_id      = [for key, subnet in aws_subnet.subnets : subnet.id][2]
  route_table_id = aws_route_table.private_route.id
}

resource "aws_route_table_association" "private_subnet_2" {
  subnet_id      = [for key, subnet in aws_subnet.subnets : subnet.id][3]
  route_table_id = aws_route_table.private_route.id
}
