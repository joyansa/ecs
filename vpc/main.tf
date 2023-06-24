resource "aws_vpc" "vpc" {
  cidr_block           = var.vpc_cidr
  instance_tenancy     = "default"
  enable_dns_hostnames = true

  tags = {
    Name = "${var.project_name}-vpc"
  }
}

resource "aws_internet_gateway" "internet_gateway" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = "${var.project_name}-igw"
  }
}

data "aws_availability_zones" "available_zones" {}

# Public Subnets
resource "aws_subnet" "public_subnet" {
  count                   = length(var.public_subnet_cidr_blocks)
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = var.public_subnet_cidr_blocks[count.index]
  availability_zone       = data.aws_availability_zones.available_zones.names[count.index]
  map_public_ip_on_launch = true

  tags = {
    Name = format("%s-public-subnet-%d", var.vpc_name, count.index + 1)
  }
}

# Private Subnets
resource "aws_subnet" "private_subnet" {
  count                   = length(var.private_subnet_cidr_blocks)
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = var.private_subnet_cidr_blocks[count.index]
  availability_zone       = data.aws_availability_zones.available_zones.names[count.index]
  map_public_ip_on_launch = false

  tags = {
    Name = format("%s-private-subnet-%d", var.vpc_name, count.index + 1)
  }
}

# Route Table
resource "aws_route_table" "main" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.internet_gateway.id
  }

  tags = {
    Name = var.rt_name
  }
}


# Associate Public Subnets with the Route Table
resource "aws_route_table_association" "public_subnet_association" {
  count          = length(var.public_subnet_cidr_blocks)
  subnet_id      = aws_subnet.public_subnet[count.index].id
  route_table_id = aws_route_table.main.id
}

# NAT Gateway
resource "aws_nat_gateway" "main" {
  count         = length(var.public_subnet_cidr_blocks)
  allocation_id = aws_eip.main[count.index].id
  subnet_id     = aws_subnet.public_subnet[count.index].id
  depends_on    = [aws_internet_gateway.internet_gateway]
}

# Elastic IP for NAT Gateway
resource "aws_eip" "main" {
  count = length(var.public_subnet_cidr_blocks)

  vpc = true

  tags = {
    Name = format("%s-eip-%d", var.vpc_name, count.index + 1)
  }
}
