variable "domain_name" {
  description = "The domain name to secure (e.g., auth.example.com)"
  type        = string
}

variable "route53_zone_id" {
  description = "The Route53 public hosted zone ID for the domain"
  type        = string
}

variable "acm_certificate_arn" {
  type        = string
  description = "ARN of ACM certificate for HTTPS listener"
}