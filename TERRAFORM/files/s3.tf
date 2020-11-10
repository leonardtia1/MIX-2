provider "aws" {
    profile = "default"
    region = "us-east-1"
}

resource "aws_s3_bucket" "terraform_s3" {
    bucket = "terraform-bucket-232"
    acl = "private"
}

/*
This is a command in terraform
*/