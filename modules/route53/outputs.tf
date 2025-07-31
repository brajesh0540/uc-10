output "hosted_zone_id" {
  value = aws_route53_zone.primary.zone_id
}

output "alb_url" {
  value = "https://${var.domain_name}/auth/"
}