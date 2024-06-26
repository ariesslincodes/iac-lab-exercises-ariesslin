variable "prefix" {
  type        = string
  description = "Prefix to many of the resources created which helps as an identifier, could be company name, solution name, etc"
  default     = "ariesslin-iac-lab"
}

variable "region" {
  type        = string
  description = "Region to deploy the solution"
  default     = "eu-central-1"
}

variable "TFC_AWS_PROVIDER_AUTH" {
  description = "Terraform auth provider"
  type        = bool
}

variable "TFC_AWS_RUN_ROLE_ARN" {
  description = "Terraform run arn"
  type        = string
}
