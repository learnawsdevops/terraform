variable "image_id" {
  type        = string
  description = "The id of the machine image (AMI) to use for the server."
  default = "ami-default"

  validation {
    condition     = length(var.image_id) > 4 && substr(var.image_id, 0, 4) == "ami-"
    error_message = "The image_id value must be a valid AMI id, starting with \"ami-\"."
  }
}


variable "instance_names" {

  default = {
    web : "t2.micro"
    backend : "t2.micro"
    db : "t3.small"
  }
  
}

variable "tags" {
  default = {
    project_name = "expense"
    ENV = "DEV"
    terraform = "True"
  }
  
}

variable "sg_id"{
    type=string
    default = "sg-07114392a79bdd59d"
}

variable "zone_id" {
  default = "Z0619374AVL6O32KVA0K"
  
}

variable "domain_name" {
  default =  "hiteshshop.store" 
}