
# Create Network ACL
resource "aws_network_acl" "hostober_network_acl" {
  vpc_id     = aws_vpc.hostober_vpc.id
  subnet_ids = [aws_subnet.hostober_public_subnet1.id, aws_subnet.hostober_public_subnet2.id]
  ingress {
    rule_no    = 100
    protocol   = "-1"
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 0
    to_port    = 0
  }
  egress {
    rule_no    = 100
    protocol   = "-1"
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 0
    to_port    = 0
  }
}
