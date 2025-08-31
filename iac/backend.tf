terraform {
  required_version = ">= 1.5.0"

  backend "s3" {
    bucket         = "devsu-terraform-state-bucket"
    key            = "eks/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "terraform-locks"
    encrypt        = true
  }
}