variable "acm_certificate_arn" {
  type        = string
  default = null
  description = "ARN of ACM certificate for HTTPS listener"
}

variable "domain_name" {
  type = string
  
}
