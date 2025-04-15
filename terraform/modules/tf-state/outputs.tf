output "s3_bucket_name" {
  description = "The name of the S3 bucket created for Terraform state storage"
  value       = aws_s3_bucket.terraform_aws_demo_state.id
}

output "s3_bucket_arn" {
  description = "The ARN of the S3 bucket"
  value       = aws_s3_bucket.terraform_aws_demo_state.arn
}


output "dynamodb_table_name" {
  description = "The name of the DynamoDB table for state locking"
  value       = aws_dynamodb_table.terraform_aws_demo_locks.name
}

output "dynamodb_table_arn" {
  description = "The ARN of the DynamoDB table"
  value       = aws_dynamodb_table.terraform_aws_demo_locks.arn
}
