


resource "aws_route53_zone" "primary" {
  name = var.domain_name
  # other options if any
}






resource "aws_route53_record" "alb_dns" {
  zone_id = aws_route53_zone.primary.zone_id
  name    = var.domain_name  # e.g., "auth.example.com"
  type    = "A"

  alias {
    name                   = var.alb_dns_name
    zone_id                = var.alb_zone_id
    evaluate_target_health = true
  }
}
