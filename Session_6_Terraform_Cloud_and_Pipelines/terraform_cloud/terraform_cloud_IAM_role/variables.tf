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

variable "tfc_aws_audience" {
  type        = string
  default     = "aws.workload.identity"
  description = "The audience value to use in run identity tokens"
}

variable "tfc_hostname" {
  type        = string
  default     = "app.terraform.io"
  description = "The hostname of the TFC or TFE instance you'd like to use with AWS"
}

variable "tfc_organization_name" {
  type        = string
  description = "The name of your Terraform Cloud organization"
  default     = "ariesslincodes"
}

variable "tfc_project_name" {
  type        = string
  default     = "ariess-test"
  description = "The project under which a workspace will be created"
}

variable "tfc_workspace_name" {
  type        = string
  default     = "ariess-test-workspace"
  description = "The name of the workspace that you'd like to create and connect to AWS"
}
