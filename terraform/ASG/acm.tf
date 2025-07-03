# module "acm" {
#   source  = "terraform-aws-modules/acm/aws"
#   version = "5.0.0"
#   domain_name  = trimsuffix(data.aws_route53_zone.route53_domain.name, ".")
#   zone_id      = data.aws_route53_zone.route53_domain.zone_id

#   subject_alternative_names = [
#     "*.neverchoose.com",
#     "neverchoose.com"
#   ]

#   wait_for_validation = true
#   validation_method = "DNS"

#   tags = local.common_tags

# }

# output "acm_certificate_arn" {
#   description = "The ARN of the certificate"
#   value       = module.acm.acm_certificate_arn
# }