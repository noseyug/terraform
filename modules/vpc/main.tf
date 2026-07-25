//vpc
resource "aws_vpc" "this" {
  cidr_block           = var.cidr_block
  enable_dns_hostnames = true

  tags = {
    Name = var.vpc_name
  }
}

//public subnet
resource "aws_subnet" "public_subnet" {
  vpc_id                  = aws_vpc.this.id
  cidr_block              = var.public_subnet_cidr
  map_public_ip_on_launch = true

  tags = {
    Name = "${var.vpc_name}-public-subnet"
  }
}

//private subnet
resource "aws_subnet" "private_subnet" {
  vpc_id                  = aws_vpc.this.id
  cidr_block              = var.private_subnet_cidr
  map_public_ip_on_launch = false

  tags = {
    Name = "${var.vpc_name}-private-subnet"
  }
}

//internet gateway of vpc
resource "aws_internet_gateway" "this" {
  vpc_id = aws_vpc.this.id

  tags = {
    Name = "${var.vpc_name}-internet-gateway"
  }
}

//elastic ip of nat gateway
resource "aws_eip" "this" {
  domain = "vpc"

  tags = {
    Name = "${var.vpc_name}-eip"
  }
}

//nat gateway in public subnet
resource "aws_nat_gateway" "this" {
  subnet_id     = aws_subnet.public_subnet.id
  allocation_id = aws_eip.this.id

  tags = {
    Name = "${var.vpc_name}-nat-gateway"
  }

  depends_on = [aws_internet_gateway.this]
}

//route table of public subnet
resource "aws_route_table" "public_subnet_route_table" {
  vpc_id = aws_vpc.this.id

  tags = {
    Name = "${var.vpc_name}-public-subnet-route-table"
  }
}

//route of public subnet
resource "aws_route" "public_subnet_route" {
  route_table_id         = aws_route_table.public_subnet_route_table.id
  destination_cidr_block = var.public_subnet_destination_cidr_block
  gateway_id             = aws_internet_gateway.this.id
}

//route table association of public subnet
resource "aws_route_table_association" "public_subnet_route_table_association" {
  route_table_id = aws_route_table.public_subnet_route_table.id
  subnet_id      = aws_subnet.public_subnet.id
}

//route table of private subnet
resource "aws_route_table" "private_subnet_route_table" {
  vpc_id = aws_vpc.this.id

  tags = {
    Name = "${var.vpc_name}-private-subnet-route-table"
  }
}

//route of private subnet
resource "aws_route" "private_subnet_route" {
  route_table_id         = aws_route_table.private_subnet_route_table.id
  destination_cidr_block = var.private_subnet_destination_cidr_block
  nat_gateway_id         = aws_nat_gateway.this.id
}

//route table association of private subnet
resource "aws_route_table_association" "private_subnet_route_table_association" {
  route_table_id = aws_route_table.private_subnet_route_table.id
  subnet_id      = aws_subnet.private_subnet.id
}
