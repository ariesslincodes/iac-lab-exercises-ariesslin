variable "prefix" {
  type        = string
  description = "Prefix for all resources"
}

variable "region" {
  type        = string
  description = "AWS region"
}

variable "vpc_cidr" {
  type        = string
  description = "VPC CIDR block"
  default     = "192.168.1.0/25"
}

variable "subnet1_cidr" {
  type        = string
  description = "Subnet 1 CIDR block"
}

variable "subnet2_cidr" {
  type        = string
  description = "Subnet 2 CIDR block"
}

variable "subnet3_cidr" {
  type        = string
  description = "Subnet 3 CIDR block"
}

variable "subnet4_cidr" {
  type        = string
  description = "Subnet 4 CIDR block"
}

variable "subnet5_cidr" {
  type        = string
  description = "Subnet 5 CIDR block"
}

variable "subnet6_cidr" {
  type        = string
  description = "Subnet 6 CIDR block"
}

variable "my_name" {
  type        = string
  description = "My name for adding in tags"
  default     = "ariesslin"
}
