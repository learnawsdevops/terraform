variable "ingress_rules"{
    default = {
      "ssh":  {
      description = "this is an ingress rule for specific sg_id"
      from_port   = 22
      to_port     = 22
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    },
    "http": {
        description = "this is an ingress rule for specific sg_id"
      from_port   = 80
      to_port     = 80
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    },
    "https": {
        description = "this is an ingress rule for specific sg_id"
      from_port   = 443
      to_port     = 443
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    },
    "redis": {
    description = "this is an ingress rule for specific sg_id",
      from_port   = 3306
      to_port     = 3306
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    },
    }
}