resource "aws_route53_record" "route53_record" {
  name    = var.domain
  type    = "A"
  zone_id = var.zone_id

  alias {
    evaluate_target_health = true
    name                   = aws_cloudfront_distribution.cloudfront_distribution.domain_name
    zone_id                = aws_cloudfront_distribution.cloudfront_distribution.hosted_zone_id
  }
}

resource "aws_route53_record" "www_route53_record" {
  name    = "www.${var.domain}"
  records = [var.domain]
  ttl     = 300
  type    = "CNAME"
  zone_id = var.zone_id
}

resource "aws_route53_record" "acm_route53_record" {
  for_each = ({
    for dvo in aws_acm_certificate.acm_certificate.domain_validation_options : dvo.domain_name => {
      name   = dvo.resource_record_name
      record = dvo.resource_record_value
      type   = dvo.resource_record_type
    }
  })

  allow_overwrite = true
  name            = each.value.name
  records         = [each.value.record]
  ttl             = 300
  type            = each.value.type
  zone_id         = var.zone_id
}
