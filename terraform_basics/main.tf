resource "aws_instance" "test"{
    ami = data.aws_ami.rhel9_devops.id
    instance_type = var.instance_type
    vpc_security_group_ids = [ var.sg_id ]

    tags ={
        Name = "Test"
    }
}

resource "aws_security_group" "allow_all" {

    name = "allow-all"
    description = "it allows everyone"
    ingress{
        from_port        = 0
        to_port          = 0
        protocol         = "-1"
        cidr_blocks      = ["0.0.0.0/0"]
        ipv6_cidr_blocks = ["::/0"]
    }
        

    egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
  
}