resource "aws_vpc" "vpc" {
  cidr_block = var.cidr_block
  enable_dns_hostnames = true
  enable_dns_support = true

  tags = {
    Name = "vpc"
  }
}
resource "aws_subnet" "pub_subnet" {
  count = length(var.pub_subnet_cidr)
  vpc_id     = aws_vpc.vpc.id
  cidr_block = var.pub_subnet_cidr[count.index]
  availability_zone = var.pub_zones[count.index]
  map_public_ip_on_launch = true

  tags = {
    Name = "pub_subnet_${count.index+1}"
  }
}
resource "aws_subnet" "priv_subnet" {
  count = length(var.priv_subnet_cidr)
  vpc_id     = aws_vpc.vpc.id
  cidr_block = var.priv_subnet_cidr[count.index]
  availability_zone = var.priv_zones[count.index]

  tags = {
    Name = "priv_subnet_${count.index+1}"
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = "igw"
  }
}

resource "aws_eip" "eip" {
  domain   = "vpc"
}

resource "aws_nat_gateway" "nat" {
  allocation_id = aws_eip.eip.id
  subnet_id     = aws_subnet.pub_subnet[0]
  

  tags = {
    Name = "NAT"
  }
  depends_on = [aws_internet_gateway.igw]
}

resource "aws_route_table" "pub_rt" {
  vpc_id = aws_vpc.vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "pub_rt"
  }
}

resource "aws_route_table" "priv_rt" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.nat.id
  }

  tags = {
    Name = "priv_rt"
  }
}

resource "aws_route_table_association" "a" {
  count = length(var.pub_subnet_cidr)
  subnet_id      = var.pub_subnet_cidr[count.index]
  route_table_id = aws_route_table.pub_rt.id
}
resource "aws_route_table_association" "b" {
  count = length(var.priv_subnet_cidr)
  subnet_id      = var.priv_subnet_cidr[count.index]
  route_table_id = aws_route_table.priv_rt.id
}

