# Generated by Terragrunt. Sig: nIlQXj57tbuaRZEa
terraform {
  backend "s3" {
    dynamodb_table = "mam-stage-788210522308-us-east-1-tfstate"
    encrypt        = true
    key            = "ec2/terraform.tfstate"
    region         = "us-east-1"
    bucket         = "mam-stage-788210522308-us-east-1-tfstate"
  }
}
