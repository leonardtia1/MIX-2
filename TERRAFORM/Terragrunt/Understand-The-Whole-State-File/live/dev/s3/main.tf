/*
terraform {
  backend "s3" {}
  required_version = ">= 0.12.26" # Required for compatibility with TF 13 style provider block

  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "~> 2.60" # Required for aws_default_route_table to work properly.
    }
  }
}
*/


resource "aws_s3_bucket" "terraform_s3" {
    bucket = "terraform-bucket-2322424222"
    acl = "private"
}
