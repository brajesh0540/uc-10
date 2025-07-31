output "alb_url" {
  value = "https://${var.domain_name}/auth/"
}

output "acm_certificate_arn" {
  value = aws_acm_certificate.cert.arn
}