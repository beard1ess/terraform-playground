resource "aws_eip" "nat" {
  count = local.subnet_count["private"]
  vpc   = true
}

