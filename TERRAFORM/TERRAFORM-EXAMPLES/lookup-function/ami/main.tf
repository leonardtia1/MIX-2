provider "aws" {
  region = var.aws_region
}

resource "aws_instance" "myec2" {
  instance_type = "t2.micro"
  ami = lookup(var.aws_amis , var.aws_region)
  //ami = "${lookup(var.aws_amis , var.aws_region)}"
  count = 1
}


