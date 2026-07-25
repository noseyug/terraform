resource "aws_security_group" "this" {
  vpc_id = var.vpc_id

  tags = {
    Name = var.sg_name
  }
}

resource "aws_vpc_security_group_ingress_rule" "this" {
  for_each = var.ingress_rules

  security_group_id = aws_security_group.this.id

  ip_protocol = each.value.ip_protocol
  from_port   = each.value.from_port
  to_port     = each.value.to_port
  cidr_ipv4   = each.value.cidr_ipv4

  tags = {
    Name = "${var.sg_name}-${each.key}-ingress-rule"
  }
}

resource "aws_vpc_security_group_egress_rule" "this" {
  security_group_id = aws_security_group.this.id

  ip_protocol = var.ip_protocol
  cidr_ipv4   = var.cidr_ipv4

  tags = {
    Name = "${var.sg_name}-egress-rule"
  }
}
