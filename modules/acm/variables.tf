variable "acm_certificate_arn" {
  type        = string
  default = null
  description = "ARN of ACM certificate for HTTPS listener"
}

variable "domain_name" {
  type = string
  
}

variable "route53_zone_id" {
  type = string
  description = "The Route53 hosted zone ID for ACM validation"
}

