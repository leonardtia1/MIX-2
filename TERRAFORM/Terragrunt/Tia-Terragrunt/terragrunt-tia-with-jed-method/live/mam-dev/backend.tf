# Generated by Terragrunt. Sig: nIlQXj57tbuaRZEa
terraform {
  backend "s3" {
    key            = "./terraform.tfstate"
    region         = "us-east-1"
    bucket         = "mam-stage-788210522308-us-east-1-tfstate"
    dynamodb_table = "mam-stage-788210522308-us-east-1-tfstate"
    encrypt        = true
  }
}
