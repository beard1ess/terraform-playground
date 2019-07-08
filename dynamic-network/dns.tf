resource "aws_route53_zone" "private" {
  count = var.optional_private_dns == "" ? 0 : 1
  name  = var.optional_private_dns

  vpc {
    vpc_id = aws_vpc.main.id
  }
}

