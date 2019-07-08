# get AZs in region
data "aws_availability_zones" "available" {
  state = "available"
}

