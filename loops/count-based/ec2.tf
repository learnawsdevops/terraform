#preference
# 1. through command line (1st tfvars (-var-file), 2nd -var)
#  terraform plan -var="image_id=ami-from_var" -var-file="roboshop.tfvars"
# 2. through env variables , for windows we can set using set command 
# 3. if above options are not used , if default mentioned in variable.tf it will fetch it else it will ask a prompt to provide in the console

resource "aws_instance" "roboshop" {
    count=length(var.instance_names)
    ami = data.aws_ami.centos9_id.id
    #instance_type = var.instance_name == "mysql" || var.instance_name == "shipping" || var.instance_name == "mysql" ? "t3.small" : "t2.micro"
    instance_type = contains(["mysql"], var.instance_names[count.index]) ? "t3.small" : "t2.micro"  # instead of having multiple expressions we can use this inbuilt containt function for better readability
    tags = merge(var.tags, {Name = var.instance_names[count.index]} ) 
    vpc_security_group_ids = [local.sg_id]  

}

resource "aws_route53_record" "roboshop" {
  count=length(var.instance_names)
  zone_id = var.zone_id
  name    = join(".",[var.instance_names[count.index], var.domain_name])  #join is an inbuild funtion , it is alternative for interpolation 
  type    = "A"
  ttl     = 1
  records = [var.instance_names[count.index] == "web" ? aws_instance.roboshop[count.index].public_ip :aws_instance.roboshop[count.index].private_ip]

}

# major difference to use local over variable
#------------------------------------------------
# Use variable when the value needs to be provided by users or should be configurable per deployment.
# Use local when you need reusable computed values within a module that won’t change dynamically.