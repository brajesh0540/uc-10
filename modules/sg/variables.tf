variable "vpc_id" {
  description = "The VPC ID where the ALB will be created"
  type        = string
  
}

variable "alb_sg_name" {
  description = "The name of the security group for the ALB"
  type        = string
  
}

variable "ecs_sg_name" {
  description = "The name of the security group for ECS services"
  type        = string
  
}