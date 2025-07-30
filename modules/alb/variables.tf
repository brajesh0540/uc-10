variable "public_subnets" {
    description = "Public subnet for the ALB"
    type        = list(string)
}

variable "vpc_id" {
    description = "VPC ID where the ALB and target group will be created"
    type        = string
  
}

variable "alb_sg_id" {
    description = "Security group ID for the ALB"
    type        = string
}

variable "name" {
    description = "Name of the ALB and target group"
    type        = string
    default     = "ecs-alb"
  
}