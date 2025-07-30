variable "subnet_ids" {
  description = "A list of subnet IDs where the ECS cluster will be created."
  type        = list(string)
  
}

variable "ecs_target_group_arn" {
  description = "The ARN of the ECS target group"
  type        = string
  
}

variable "cluster_name" {
  description = "The name of the ECS cluster"
  type        = string
  default     = "ecs-fargate-cluster"
  
}

variable "services" {
  description = "A map of services to be deployed in the ECS cluster."
  type        = map(object({
    image       = string
    cpu         = number
    memory      = number
      container_port = number
      target_group_arn = string
  }))
  
}

variable "execution_role_arn" {
  description = "The ARN of the execution role for the ECS task."
  type        = string
  
}

variable "security_groups" {
  description = "A list of security group IDs to associate with the ECS service."
  type        = list(string)
  default     = []
  
}

variable "task_arn_role" {
  description = "The ARN of the task role for the ECS task."
  type        = string
  
}


