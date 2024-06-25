output "nat_eip_ip_addr" {
  value       = module.vpc.nat_public_ips[0]
  description = "The elastic IP address for NAT gateway."
}

output "vpc_id" {
  value       = module.vpc.vpc_id
  description = "The ID of the VPC."
}
