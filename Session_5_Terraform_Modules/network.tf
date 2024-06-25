module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = format("%s-vpc", var.prefix)
  cidr = var.vpc_cidr

  azs = slice(data.aws_availability_zones.available.names, 0, 2)

  intra_subnets   = [for i in range(4, 6) : cidrsubnet(var.vpc_cidr, 3, i)]
  private_subnets = [for i in range(2, 4) : cidrsubnet(var.vpc_cidr, 3, i)]
  public_subnets  = [for i in range(0, 2) : cidrsubnet(var.vpc_cidr, 3, i)]

  enable_nat_gateway     = true
  single_nat_gateway     = true
  one_nat_gateway_per_az = false

  enable_dns_support   = true
  enable_dns_hostnames = true
  instance_tenancy     = "default"

  tags = {
    Name = format("%s-vpc", var.prefix)
  }
}

data "aws_availability_zones" "available" {}
