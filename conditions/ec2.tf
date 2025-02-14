#preference
# 1. through command line (1st tfvars (-var-file), 2nd -var)
#  terraform plan -var="image_id=ami-from_var" -var-file="roboshop.tfvars"
# 2. through env variables , for windows we can set using set command 
# 3. if above options are not used , if default mentioned in variable.tf it will fetch it else it will ask a prompt to provide in the console

resource "aws_instance" "test" {
    ami = data.aws_ami.centos9_id.id
    instance_type = var.instance_name == "mongodb" || var.instance_name == "shipping" || var.instance_name == "mysql" ? "t3.small" : "t2.micro"
}