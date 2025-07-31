variable "domain_name" {
  description = "The domain name to secure (e.g., auth.example.com)"
  type        = string
}

variable "acm_certificate_arn" {
  type        = string
  default = null
  description = "ARN of ACM certificate for HTTPS listener"
}

variable "route53_zone_id" {
  type = string
  description = "The Route53 hosted zone ID for creating DNS validation records."
}
