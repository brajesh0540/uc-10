variable "domain_name" {
  type = string
  
}

variable "hosted_zone_id" {
  type        = string
  description = "The ID of the Route53 hosted zone"
}

variable "alb_dns_name" {
  type        = string
  description = "The DNS name of the ALB to create alias record for"
}

variable "alb_zone_id" {
  type        = string
  description = "The hosted zone ID of the ALB"
}