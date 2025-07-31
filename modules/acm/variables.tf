variable "domain_name" {
  description = "The domain name to secure (e.g., auth.example.com)"
  type        = string
}

variable "acm_certificate_arn" {
  type        = string
  default = null
  description = "ARN of ACM certificate for HTTPS listener"
}