variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
  
}

variable "vpc_name" {
  description = "Name of the VPC"
  type        = string
  
}

variable "public_subnets" {
  description = "List of public subnets for the VPC"
  type        = list(string)
  
}

variable "private_subnets" {
  description = "List of private subnets for the VPC"
  type        = list(string)
  
}

variable "alb_sg_name" {
  description = "Security group ID for the ALB"
  type        = string
  
}

variable "ecs_sg_name" {
  description = "Security group ID for the ECS service"
  type        = string
  
}

variable "ecr_repo_name" {
  description = "The desired number of instances for the ECS services"
  type        = list(string)
  
}

variable "execution_role_arn" {
  description = "ARN of the execution role for ECS tasks"
  type        = string
  
}

variable "azs" {
  description = "List of availability zones"
  type        = list(string)
  
}

variable "cluster_name" {
  description = "Name of the ECS cluster"
  type        = string
}


variable "domain_name" {
  description = "The domain name to secure (e.g., auth.example.com)"
  type        = string
}