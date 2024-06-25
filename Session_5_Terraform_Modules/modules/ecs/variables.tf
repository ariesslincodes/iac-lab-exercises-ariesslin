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
