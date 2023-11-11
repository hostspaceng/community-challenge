
# Create an internet gateway
resource "aws_internet_gateway" "hostober_igw" {
  vpc_id = aws_vpc.hostober_vpc.id

  tags = {
    Name = "hostoberInternetGateway"
  }
}