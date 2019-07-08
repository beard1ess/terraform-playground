resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Terraform   = "true"
    Environment = "development"
  }
}

resource "aws_nat_gateway" "gw" {
  count         = local.subnet_count["private"]
  allocation_id = element(aws_eip.nat.*.id, count.index)
  subnet_id     = element(aws_subnet.private.*.id, count.index)
}

