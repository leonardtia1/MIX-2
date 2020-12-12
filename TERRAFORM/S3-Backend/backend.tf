terraform {
  backend "s3" {
    access_key = " "
    secret_key = " "
    bucket = "terraform-tia-backend"
    key    = "remotedemo.tfstate" // this is the tfstate file name
    region = "us-east-1"
    dynamodb_table = "terraform-s3-state-lock"
  }
}