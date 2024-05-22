### Note:

1. When encountering errors like:

   ```
   ╷
   │ Error: Retrieving AWS account details: validating provider credentials: retrieving caller identity from STS: operation error STS: GetCallerIdentity, https response error StatusCode: 403, RequestID: 183dd2a4-96a0-4b4b-a60c-a113e3772067, api error InvalidClientTokenId: The security token included in the request is invalid.
   │
   │   with provider["registry.terraform.io/hashicorp/aws"],
   │   on main.tf line 15, in provider "aws":
   │   15: provider "aws" {
   │
   ╵
   ```

   try to use:

   ```bash
   export AWS_PROFILE=infra_train
   ```

2. To check the VPC created in AWS from CLI:

   ```bash
   aws ec2 describe-vpcs --region eu-central-1 --filters "Name=tag:Name,Values=iac-lab-placeholder:*"
   ```

