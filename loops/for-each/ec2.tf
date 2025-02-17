#preference
# 1. through command line (1st tfvars (-var-file), 2nd -var)
#  terraform plan -var="image_id=ami-from_var" -var-file="roboshop.tfvars"
# 2. through env variables , for windows we can set using set command 
# 3. if above options are not used , if default mentioned in variable.tf it will fetch it else it will ask a prompt to provide in the console

resource "aws_instance" "roboshop" {
    #count=length(var.instance_names)
    for_each = var.instance_names
    ami = data.aws_ami.centos9_id.id
    instance_type = each.value
    tags = merge(var.tags, {Name = each.key} ) 
    vpc_security_group_ids = [local.sg_id]  

}

resource "aws_route53_record" "roboshop" {
  for_each = aws_instance.roboshop  #o/p aws_instance.roboshop : {{},{},{}....{}} map(map)
  zone_id = var.zone_id
  name    = join(".",[each.key, var.domain_name])  #join is an inbuild funtion , it is alternative for interpolation 
  type    = "A"
  ttl     = 1
  records = [each.key == "web" ? each.value.public_ip :each.value.private_ip]

}

# major difference to use local over variable
#------------------------------------------------
# Use variable when the value needs to be provided by users or should be configurable per deployment.
# Use local when you need reusable computed values within a module that won’t change dynamically.