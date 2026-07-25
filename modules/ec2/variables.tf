variable "ec2_name" {
  type    = string
  default = "my-ec2"
}
variable "subnet_id" {
  type = string
}

variable "sg_ids" {
  type = list(string)
}

variable "ami" {
  type = string
}

variable "instance_type" {
  type = string
}

variable "key_name" {
  type = string
}
