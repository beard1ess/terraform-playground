resource "aws_subnet" "public" {
  count = local.subnet_count["public"]

  cidr_block = cidrsubnet(var.primary_cidr, local.subnet_calc["netbits"], count.index)

  map_public_ip_on_launch = true
  availability_zone       = data.aws_availability_zones.available.names[count.index]
  vpc_id                  = aws_vpc.main.id

  tags = {
    Name        = "public"
    Terraform   = "true"
    Environment = "development"
  }
}

resource "aws_subnet" "private" {
  count = local.subnet_count["private"]

  cidr_block = cidrsubnet(
    var.primary_cidr,
    local.subnet_calc["netbits"],
    local.az_count + count.index,
  )

  availability_zone = data.aws_availability_zones.available.names[count.index]
  vpc_id            = aws_vpc.main.id

  tags = {
    Name        = "private"
    Terraform   = "true"
    Environment = "development"
  }
}

locals {
  az_count = var.dynamic_subnets == "true" ? length(data.aws_availability_zones.available.names) : var.subnet_pairs

  subnet_count = {
    public  = local.az_count
    private = local.az_count
  }

  subnet_calc = {
    netbits = ceil(log(local.az_count * 2, 2))
  }
}

