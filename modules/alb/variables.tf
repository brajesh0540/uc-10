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

variable "cognito_user_pool_arn" {
  type = string
}

variable "cognito_user_pool_client_id" {
  type = string
}

variable "cognito_user_pool_domain" {
  type = string
}

variable "cognito_user_pool_client_secret" {
  type = string
  default = null
  description = "NOT REQUIRED: For ALB Cognito auth, client secret is handled internally when client is created with generate_secret=true."
}

