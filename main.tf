module "my_vpc" {
  source = "./modules/vpc"

  vpc_name            = var.vpc_name
  cidr_block          = var.cidr_block
  public_subnet_cidr  = var.public_subnet_cidr
  private_subnet_cidr = var.private_subnet_cidr
}

module "my_sg" {
  source = "./modules/sg"

  sg_name       = var.sg_name
  vpc_id        = module.my_vpc.vpc_id
  ingress_rules = var.ingress_rules
}

module "my_ec2" {
  source = "./modules/ec2"

  ec2_name  = var.ec2_name
  subnet_id = module.my_vpc.public_subnet_id
  sg_ids    = [module.my_sg.sg_id]

  ami           = data.aws_ami.ubuntu.id
  instance_type = var.instance_type
  key_name      = var.key_name
}

# ! test

