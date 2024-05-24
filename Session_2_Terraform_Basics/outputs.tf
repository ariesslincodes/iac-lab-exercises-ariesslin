output "nat_eip_ip_addr" {
  value       = aws_eip.nat.public_ip
  description = "The elastic IP address for NAT gateway."
}