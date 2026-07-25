variable "sg_name" {
  type    = string
  default = "my-sg"
}

variable "vpc_id" {
  type    = string
  default = ""
}

variable "ingress_rules" {
  type = map(object({

    ip_protocol = string
    from_port   = number
    to_port     = number
    cidr_ipv4   = string
  }))

  default = {}
}

variable "ip_protocol" {
  type    = string
  default = "-1"
}

variable "cidr_ipv4" {
  type    = string
  default = "0.0.0.0/0"
}
