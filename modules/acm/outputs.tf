output "alb_url" {
  value = "https://${var.domain_name}/auth/"
}

output "acm_certificate_arn" {
  value = aws_acm_certificate.cert.arn
}

output "hosted_zone_id" {
  value = aws_route53_zone.primary.zone_id
}
