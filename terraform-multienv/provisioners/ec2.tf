resource "aws_instance" "test"{
    ami = data.aws_ami.rhel9_devops.id
    instance_type = "t2.micro"
    vpc_security_group_ids = [ aws_security_group.allow_all.id]

    tags ={
        Name = "Test"
    }

    provisioner "local-exec" {
    command = "echo The server's IP address is ${self.private_ip}"
    }

    provisioner "local-exec" {
    
    command = "echo 'Destroyed now'"
    when    = destroy
  }

  connection {
    type     = "ssh"
    user     = "ec2-user"
    password = "DevOps321"
    host     = self.public_ip
  }

  provisioner "remote-exec" {
    inline = [
      "sudo dnf install nginx -y",
      "sudo systemctl start nginx"
    ]
  }
}

resource "aws_security_group" "allow_all" {

    name = "allow-all-provisioner"
    description = "it allows everyone"
    ingress{
        from_port        = 0
        to_port          = 0
        protocol         = "-1"
        cidr_blocks      = ["0.0.0.0/0"]
    }
        

    egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }
  
}

data "aws_ami" "rhel9_devops" {
  owners      = ["973714476881"] # Owner ID from AWS CLI output
  most_recent = true             # Ensures you get the latest AMI

  filter {
    name   = "name"
    values = ["RHEL-9-DevOps-Practice"]
  }
}