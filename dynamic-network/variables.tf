variable "primary_cidr" {
  default     = "10.10.0.0/16"
  description = "cidr for VPC. must conform to RFC1918"
}

variable "subnet_pairs" {
  description = "number of subnet pairs (public and private) to create. INACTIVE if using dynamic subnetting"
  default     = 1
}

variable "dynamic_subnets" {
  description = "true/false to determine if all AZs should be filled."
  default     = true
  type        = bool
}

variable "optional_private_dns" {
  description = "create a private hosted zone to attach to vpc with the given name"
  default     = ""
}

