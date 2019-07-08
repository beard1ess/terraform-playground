variable "primary_cidr" {
  default = "10.10.0.0/16"
}

variable "secondary_cidr" {
  default = "172.2.0.0/24"
}

variable "subnet_pairs" {
  default = 1
}

variable "dynamic_subnets" {
  description = "true/false to determine if all AZs should be filled. boolean has to be string lol?"
  default     = "true"
}

variable "optional_private_dns" {
  description = "create a private hosted zone to attach to vpc"
  default     = ""
}

