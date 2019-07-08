# public routes
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "public"
  }
}

resource "aws_route_table_association" "public" {
  count          = local.subnet_count["public"]
  subnet_id      = element(aws_subnet.public.*.id, count.index)
  route_table_id = aws_route_table.public.id
  depends_on     = [aws_subnet.public]
}

resource "aws_route" "igw" {
  route_table_id         = aws_route_table.public.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.gw.id
  depends_on = [
    aws_internet_gateway.gw,
    aws_route_table.public,
  ]
}

# private routes
resource "aws_route_table" "private" {
  count  = local.subnet_count["private"]
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "private"
  }
}

resource "aws_route" "nat" {
  count                  = local.subnet_count["private"]
  route_table_id         = element(aws_route_table.private.*.id, count.index)
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = element(aws_nat_gateway.gw.*.id, count.index)
  depends_on = [
    aws_internet_gateway.gw,
    aws_route_table.private,
  ]
}

resource "aws_route_table_association" "private" {
  count          = local.subnet_count["private"]
  subnet_id      = element(aws_subnet.private.*.id, count.index)
  route_table_id = element(aws_route_table.private.*.id, count.index)
}

