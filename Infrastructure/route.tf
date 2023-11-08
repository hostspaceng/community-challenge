
# Create Public Route Table
resource "aws_route_table" "hostober_route_table_public" {
  vpc_id = aws_vpc.hostober_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.hostober_igw.id
  }
  tags = {
    Name = "hostober_route_table_public"
  }
}
resource "aws_route_table" "hostober_route_table_nat" {
  vpc_id = aws_vpc.hostober_vpc.id

  route {
    # cidr_block = var.vpc_cidr
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.app_server_nat_gateway.id
  }

  tags = {
    Name = "hostober-rtb-nat"
  }
}

# Associate public subnet 1 with public route table
resource "aws_route_table_association" "hostober_public_subnet1_association" {
  subnet_id      = aws_subnet.hostober_public_subnet1.id
  route_table_id = aws_route_table.hostober_route_table_public.id
}

# Associate public subnet 1 with public route table
resource "aws_route_table_association" "hostober_public_subnet2_association" {
  subnet_id      = aws_subnet.hostober_public_subnet2.id
  route_table_id = aws_route_table.hostober_route_table_public.id
}

# Associate private subnet with nat gateway via route table
resource "aws_route_table_association" "hostober-rtb-priv-assoc" {
  subnet_id      = aws_subnet.hostober_private_subnet.id
  route_table_id = aws_route_table.hostober_route_table_nat.id
}