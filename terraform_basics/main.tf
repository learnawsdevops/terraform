resource "aws_instance" "test"{
    count =2 
    ami = data.aws_ami.rhel9_devops.id
    instance_type = var.instance_type
    vpc_security_group_ids = [ aws_security_group.allow_all.id]

    tags ={
        Name = ""
    }
}

resource "aws_security_group" "allow_all" {

    name = "allow-all-basic"
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