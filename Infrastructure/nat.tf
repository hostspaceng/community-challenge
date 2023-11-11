# Create a NAT gateway
resource "aws_nat_gateway" "app_server_nat_gateway" {
  allocation_id = aws_eip.app_server.id
  subnet_id     = aws_subnet.hostober_public_subnet1.id
}

# Create Elastic IP
resource "aws_eip" "app_server" {
  domain = "vpc"
  instance = aws_instance.app_server.id

  tags = {
    Name = "aws_eip"
  }

}
