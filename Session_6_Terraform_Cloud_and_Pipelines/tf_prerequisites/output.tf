output "bucket_name" {
  value       = aws_s3_bucket.terraform_state.bucket
  description = "The name of the S3 bucket."
}

output "dynamodb_table_name" {
  value       = aws_dynamodb_table.terraform_locks.name
  description = "The name of the DynamoDB table."
}

output "github_actions_iam_role" {
  value       = aws_iam_role.github_actions_role.arn
  description = "The ARN of the GitHub Actions role."
}
