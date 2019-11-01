# Configure the AWS Provider
provider "aws" {
  version = "~> 2.0"
  region  = "eu-central-1"
}

data "aws_vpc" "default" {
  default = true
}

data "aws_subnet_ids" "default" {
  vpc_id = "${data.aws_vpc.default.id}"
}

data "aws_subnet" "default" {
  count = "${length(data.aws_subnet_ids.default.ids)}"
  id    = "${tolist(data.aws_subnet_ids.default.ids)[count.index]}"
}

data "aws_route53_zone" "selected" {
  name         = "qndesign.studio"
}

data "aws_region" "current" {}

data "aws_caller_identity" "current" {}

module "es-cluster" {
  source = "../"

  name                      = "example"
  vpc_id                    = "${data.aws_vpc.default.id}"
  subnet_ids                = [ "${data.aws_subnet.default.0.id}", "${data.aws_subnet.default.1.id}" ]
  zone_id                   = "${data.aws_route53_zone.selected.zone_id}"
  itype                     = "m4.large.elasticsearch"
  icount                    = 2
  zone_awareness            = true
  ingress_allow_cidr_blocks = "${tolist(data.aws_subnet.default.*.cidr_block)}"
  access_policies           = <<CONFIG
{   
    "Version": "2012-10-17",
    "Statement": [
        {
            "Action": "es:*",
            "Principal": "*",
            "Effect": "Allow",
            "Resource": "arn:aws:es:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:domain/example/*"
        }
    ]
}
CONFIG

}