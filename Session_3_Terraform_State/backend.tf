terraform {
  required_version = ">= 1.8.0"
  backend "s3" {
    bucket = "ariesslin-iac-lab-tfstate"
    key    = "backend/terraform.tfstate"
    region = "eu-central-1"

    dynamodb_table = "ariesslin-iac-lab-tfstate-locks"
    encrypt        = true
  }
}
