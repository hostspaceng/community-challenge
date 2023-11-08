
# Create Public Subnet_1
resource "aws_subnet" "hostober_public_subnet1" {
  vpc_id                  = aws_vpc.hostober_vpc.id
  cidr_block              = "10.0.1.0/24"
  map_public_ip_on_launch = true
  availability_zone       = var.av_zone1
  tags = {
    Name = "hostober_public_subnet1"
  }
}

# Create Public Subnet_2
resource "aws_subnet" "hostober_public_subnet2" {
  vpc_id                  = aws_vpc.hostober_vpc.id
  cidr_block              = "10.0.2.0/24"
  map_public_ip_on_launch = true
  availability_zone       = var.av_zone2
  tags = {
    Name = "hostober_public_subnet2"
  }
}

# Create a private subnet
resource "aws_subnet" "hostober_private_subnet" {
  vpc_id            = aws_vpc.hostober_vpc.id
  cidr_block        = "10.0.3.0/24"
  availability_zone = var.av_zone1

  tags = {
    Name = "hostober_private_Subnet"
  }
}
