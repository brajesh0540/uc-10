resource "aws_acm_certificate" "cert" {
  domain_name       = var.domain_name                  # e.g., "auth.example.com"
  validation_method = "DNS"

  subject_alternative_names = [
    "www.${var.domain_name}"
  ]

  tags = {
    Name = "my-acm-cert"
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_acm_certificate_validation" "cert_validation" {
  certificate_arn         = aws_acm_certificate.cert.arn
  validation_record_fqdns = [for record in aws_route53_record.cert_validation : record.fqdn]
}

resource "aws_route53_record" "cert_validation" {
  for_each = {
    for dvo in aws_acm_certificate.cert.domain_validation_options : dvo.domain_name => {
      name   = dvo.resource_record_name
      type   = dvo.resource_record_type
      record = dvo.resource_record_value
    }
  }

  zone_id = aws_route53_zone.primary.zone_id  # Your Route53 hosted zone ID
  name    = each.value.name
  type    = each.value.type
  records = [each.value.record]
  ttl     = 60
}

resource "aws_route53_record" "alb_dns" {
  zone_id = aws_route53_zone.primary.zone_id
  name    = var.domain_name  # e.g., "auth.example.com"
  type    = "A"

  alias {
    name                   = aws_lb.ecs_alb.dns_name
    zone_id                = aws_lb.alb.alb_zone_id
    evaluate_target_health = true
  }
}

resource "aws_route53_zone" "primary" {
  name = var.domain_name
  # other options if any
}

