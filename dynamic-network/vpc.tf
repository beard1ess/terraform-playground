resource "aws_vpc" "main" {
  cidr_block = var.primary_cidr

  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Terraform   = "true"
    Environment = "development"
  }
}
