data "aws_ami" "rhel9_devops" {
  owners      = ["973714476881"] # Owner ID from AWS CLI output
  most_recent = true             # Ensures you get the latest AMI

  filter {
    name   = "name"
    values = ["RHEL-9-DevOps-Practice"]
  }
}