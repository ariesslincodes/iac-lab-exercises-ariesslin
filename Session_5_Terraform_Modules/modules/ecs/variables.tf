variable "prefix" {
  type        = string
  description = "Prefix for all resources"
}

variable "region" {
  type        = string
  description = "AWS region"
}

variable "vpc_id" {
  type        = string
  description = "VPC ID"
}

variable "private_subnet_ids" {
  type        = list(any)
  description = "List of private subnet IDs"
}

variable "alb_target_group_arn" {
  type        = string
  description = "ALB target group ARN"
}

variable "alb_security_group_id" {
  type        = string
  description = "ALB security group ID"
}

variable "db_address" {
  type        = string
  description = "Database address"
}

variable "db_name" {
  type        = string
  description = "Database name"
}

variable "db_username" {
  type        = string
  description = "Database username"
}

variable "db_secret_arn" {
  type        = string
  description = "Database secret ARN"
}

variable "db_secret_key_id" {
  type        = string
  description = "Database secret key ID"
}
