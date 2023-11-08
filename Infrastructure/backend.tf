
# Save state_file in an S3 bucket
terraform {
  backend "s3" {
    bucket         = "hostober"
    key            = "terraform.tfstate"
    region         = "us-east-1"
  }
}