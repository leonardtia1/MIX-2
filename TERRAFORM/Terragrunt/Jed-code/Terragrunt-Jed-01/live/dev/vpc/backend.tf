# Generated by Terragrunt. Sig: nIlQXj57tbuaRZEa
terraform {
  backend "s3" {
    region         = "us-east-1"
    bucket         = "mam-dev-788210522308-us-east-1-tfstate"
    dynamodb_table = "mam-dev-788210522308-us-east-1-tfstate"
    encrypt        = true
    key            = "vpc/terraform.tfstate"
  }
}
