# vpc 
resource "aws_vpc" "vpc" {
  cidr_block       = var.vpc_cidr_block
  instance_tenancy = var.instance_tenancy
  tags = {
    Name : var.vpc_name
  }
}

# internet-gateway
resource "aws_internet_gateway" "internet_gateway" {
  vpc_id = aws_vpc.vpc.id
  tags = {
    Name : "${var.vpc_name}-igw"
  }
}

# public subnet
resource "aws_subnet" "public_subnet" {
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = var.public_subnet_cidr_block
  availability_zone = var.availability_zones
  tags = {
    Name : "${var.vpc_name}-public-subnet"
  }
}

# public route table
resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.internet_gateway.id
  }
  tags = {
    Name : "${var.vpc_name}-public-rt"
  }
}

# public route-table association
resource "aws_route_table_association" "public_route_table_association" {
  route_table_id = aws_route_table.public_route_table.id
  subnet_id      = aws_subnet.public_subnet.id
}

# private subnet
resource "aws_subnet" "private_subnet" {
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = var.private_subnet_cidr_block
  availability_zone = var.availability_zones
  tags = {
    Name : "${var.vpc_name}-private-subnet"
  }
}

# private route table
resource "aws_route_table" "private_route_table" {
  vpc_id = aws_vpc.vpc.id
  tags = {
    Name : "${var.vpc_name}-private-rt"
  }
}

# private route-table association
resource "aws_route_table_association" "private_route_table_association" {
  route_table_id = aws_route_table.private_route_table.id
  subnet_id      = aws_subnet.private_subnet.id
}
