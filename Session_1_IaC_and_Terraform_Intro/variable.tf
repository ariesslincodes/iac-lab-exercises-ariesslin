
variable "vpc_cidr" {
  type        = string
  description = "VPC CIDR block"
  default     = "192.168.1.0/25"
}

variable "my_name" {
  type        = string
  description = "My name for adding in tags"
  default     = "ariesslin"
}
