module "ec2" {
    //source            = "../../terraform/ec2/"
    source = "github.com/leonardtia1/test-module/terraform/ec2"
    
    ami               = "ami-04d29b6f966df1537"
    instance_type     = "t2.micro"
    availability_zone = "us-east-1c"
    key_name          = "jenkins-key"
}