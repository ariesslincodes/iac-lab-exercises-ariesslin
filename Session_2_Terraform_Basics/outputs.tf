output "eip_ip_addr" {
  value       = aws_eip.nat.public_ip
  description = "The public IP address of the elastic ip for nat."
}