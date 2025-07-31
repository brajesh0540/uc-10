variable "domain_name" {
    type = string
  
}

variable "route53_zone_id" {
    type = string
  
}

variable "domain_name" {
  description = "The domain name to secure (e.g., auth.example.com)"
  type        = string
}

variable "route53_zone_id" {
  description = "The Route53 public hosted zone ID for the domain"
  type        = string
}