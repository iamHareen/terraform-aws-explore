# For a production setup, you might want to use S3 backend
# terraform {
#   backend "s3" {
#     bucket         = "iac-explore-assignment"  # Replace with your actual bucket name
#     key            = "demo/path.tfstate"            # Path to state file within bucket
#     region         = "us-east-1"                    # Region where bucket exists
#     dynamodb_table = "dynamo-terraform-aws-demo"    # For state locking to prevent conflicts
#     encrypt        = true                           # Encrypt state data at rest
#   }
# }


# For local development, you can use the local backend
terraform {
  backend "local" {
    path = "terraform.tfstate"
  }
}

