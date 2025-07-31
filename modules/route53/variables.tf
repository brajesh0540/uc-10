variable "domain_name" {
  description = "The domain name to secure (e.g., auth.example.com)"
  type        = string
}

variable "route53_zone_id" {
  type = string
  description = "The Route53 hosted zone ID for creating DNS validation records."
}