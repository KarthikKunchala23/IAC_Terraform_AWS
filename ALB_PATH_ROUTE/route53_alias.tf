resource "aws_route53_record" "dns" {
  zone_id = data.aws_route53_zone.certificate_route53_zone.zone_id
  name    = "apps.neverchoose.com"
  type    = "A"
#   ttl     = 300
#   records = [aws_eip.lb.public_ip]
  alias {
    name                   = module.alb.dns_name
    zone_id                = module.alb.zone_id
    evaluate_target_health = true
  }
}