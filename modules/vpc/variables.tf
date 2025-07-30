variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
  
}

variable "vpc_name" {
  description = "Name of the VPC"
  type        = string
  default     = "my-vpc"
  
}

variable "public_subnets" {
  description = "List of public subnets for the VPC"
  type        = list(string)

  
}

variable "private_subnets" {
  description = "List of private subnets for the VPC"
  type        = list(string)
  
}

variable "azs" {
  description = "values for availability zones"
  type        = list(string)
  
}