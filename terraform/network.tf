
# Overall VPC
resource "aws_vpc" "main" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"

  tags = var.tags
}

# Internet Gateway
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id

  tags = var.tags
}

#Public Subnets

module "Public_Subnet_A" {
  source            = "./modules/Subnets"
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.0.0.0/24"
  availability_zone = "${var.region}a"

  tags = var.tags
}

module "Public_Subnet_B" {
  source            = "./modules/Subnets"
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = "${var.region}b"

  tags = var.tags
}

# Private Subnets for Backend/API Service

module "Private_Subnet_A" {
  source            = "./modules/Subnets"
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.0.2.0/24"
  availability_zone = "${var.region}a"

  tags = var.tags
}

module "Private_Subnet_B" {
  source            = "./modules/Subnets"
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.0.3.0/24"
  availability_zone = "${var.region}b"

  tags = var.tags
}

# Route Table for Public subnets and Internet Gateway

resource "aws_route_table" "public-rt" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = var.tags
}

# Association RT for Public Subnets

resource "aws_route_table_association" "public-a" {
  route_table_id = aws_route_table.public-rt.id
  subnet_id      = module.Public_Subnet_A.id
}

resource "aws_route_table_association" "public-b" {
  route_table_id = aws_route_table.public-rt.id
  subnet_id      = module.Public_Subnet_B.id
}

# API Service subnet route table and NAT

resource "aws_eip" "nat-1-eip" {
  domain = "vpc"
}

resource "aws_nat_gateway" "private-NAT" {
  subnet_id     = module.Public_Subnet_A.id
  allocation_id = aws_eip.nat-1-eip.id

  depends_on = [aws_internet_gateway.igw]

  tags = var.tags
}

resource "aws_route_table" "private-tb" {
  vpc_id = aws_vpc.main.id
  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.private-NAT.id
  }

  tags = var.tags
}

resource "aws_route_table_association" "private-a" {
  route_table_id = aws_route_table.private-tb.id
  subnet_id      = module.Private_Subnet_A.id
}

resource "aws_route_table_association" "private-b" {
  route_table_id = aws_route_table.private-tb.id
  subnet_id      = module.Private_Subnet_B.id
}
