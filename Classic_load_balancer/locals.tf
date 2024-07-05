locals {
  owners = var.bussiness_team
  environment = var.environment
#   name = "${local.owners}-${local.environment}"
  name = "${var.bussiness_team}-${var.environment}"

  common_tags = {
    owners = local.owners
    environment = local.environment
  }
}