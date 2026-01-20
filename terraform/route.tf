resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.week5-vpc.id

  tags = {
    Name = "week5-gw"
  }
}

resource "aws_route_table" "week5-rt" {
  vpc_id = aws_vpc.week5-vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }

  tags = {
    Name = "public-rt"
  }
}

resource "aws_route_table_association" "week5-rt-a" {
  subnet_id      = aws_subnet.public-week5-subnet.id
  route_table_id = aws_route_table.week5-rt.id 
}