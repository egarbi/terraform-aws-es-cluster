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

module "es-cluster" {
  source = "../"

  name                      = "example"
  vpc_id                    = "${data.aws_vpc.default.id}"
  subnet_ids                = "${tolist(data.aws_subnet_ids.default.ids)}" 
  zone_id                   = "${data.aws_route53_zone.selected.zone_id}"
  itype                     = "m4.large.elasticsearch"
  icount                    = 3
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
            "Condition": {
                "IpAddress": {"aws:SourceIp": ["156.114.160.31/32"]}
            }
        }
    ]
}
CONFIG

}