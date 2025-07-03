# data "aws_route53_zone" "route53_domain" {
#   name         = "neverchoose.com"
# #   private_zone = true
# }

# output "route53_zoneid" {
#   description = "Hosted Zone id of the desired Hosted Zone."
#   value = data.aws_route53_zone.route53_domain.zone_id
# }

# output "route53_zone_name" {
#   description = "Hosted Zone name of the desired Hosted Zone."
#   value = data.aws_route53_zone.route53_domain.name
# }
