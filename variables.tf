variable "region" {
  type    = string
  default = "ap-southeast-1"
}

variable "vpc_name" {
  type    = string
  default = "huhu"
}

variable "cidr_block" {
  type    = string
  default = "11.0.0.0/16"
}

variable "public_subnet_cidr" {
  type    = string
  default = "11.0.1.0/24"
}

variable "private_subnet_cidr" {
  type    = string
  default = "11.0.2.0/24"
}

variable "sg_name" {
  type    = string
  default = "huhu"
}

variable "ingress_rules" {

  type = map(object({

    ip_protocol = string
    from_port   = number
    to_port     = number
    cidr_ipv4   = string
  }))

  default = {
    ssh = {
      ip_protocol = "tcp"
      from_port   = 22
      to_port     = 22
      cidr_ipv4   = "27.79.122.236/32"
    }
  }
}
variable "ec2_name" {
  type    = string
  default = "huhu"
}

variable "instance_type" {
  type    = string
  default = "t3.micro"
}

variable "key_name" {
  type    = string
  default = "key"
}
