resource "aws_instance" "test"{
    ami = data.aws_ami.centos9_id.id
    instance_type = terraform.workspace == "dev"? "t2.micro" : "t3.small"
    tags ={
        Name = "Test"
    }
}

data "aws_ami" "centos9_id" {
  owners      = ["973714476881"] # Owner ID from AWS CLI output
  most_recent = true             # Ensures you get the latest AMI

  filter {
    name   = "name"
    values = ["RHEL-9-DevOps-Practice"]
  }
}