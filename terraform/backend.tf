# Store Terraform state in S3 bucket
# Remote state storage provides better collaboration and security
terraform {
  backend "s3" {
    bucket         = "s3-terraform-aws-demo"  # Replace with your actual bucket name
    key            = "demo/path.tfstate"            # Path to state file within bucket
    region         = "us-east-1"                    # Region where bucket exists
    dynamodb_table = "dynamo-terraform-aws-demo"    # For state locking to prevent conflicts
    encrypt        = true                           # Encrypt state data at rest
  }
}
