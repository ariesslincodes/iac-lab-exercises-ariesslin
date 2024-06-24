module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = format("%s-vpc", var.prefix)
  cidr = var.vpc_cidr

  azs = slice(data.aws_availability_zones.available.names, 0, 2)

  private_subnets = [
    for i in range(2, 6) : cidrsubnet(var.vpc_cidr, 3, i)
  ]

  public_subnets = [
    for i in range(0, 2) : cidrsubnet(var.vpc_cidr, 3, i)
  ]

  enable_nat_gateway = true
  enable_vpn_gateway = true

  enable_dns_support   = "true"
  enable_dns_hostnames = "true"
  instance_tenancy     = "default"

  tags = {
    Name = format("%s-vpc", var.prefix)
  }
}

data "aws_availability_zones" "available" {}

resource "aws_internet_gateway" "igw" {
  vpc_id = module.vpc.vpc_id

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
  subnet_id     = module.vpc.public_subnets[0]

  tags = {
    Name = format("%s-ngw", var.prefix)
  }
}

resource "aws_route_table" "public_route" {
  vpc_id = module.vpc.vpc_id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = format("%s-route-table-for-public-subnet", var.prefix)
  }
}

resource "aws_route_table" "private_route" {
  vpc_id = module.vpc.vpc_id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.ngw.id
  }

  tags = {
    Name = format("%s-route-table-for-private-subnet", var.prefix)
  }
}

resource "aws_route_table_association" "public_subnets" {
  count          = length(module.vpc.public_subnets)
  subnet_id      = module.vpc.public_subnets[count.index]
  route_table_id = aws_route_table.public_route.id
}

resource "aws_route_table_association" "private_subnets" {
  count          = 2
  subnet_id      = module.vpc.private_subnets[count.index]
  route_table_id = aws_route_table.private_route.id
}
