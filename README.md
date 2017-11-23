AWS Elasticsearch Service Terraform Module
==========================================

Usage:

```hcl
module "es-cluster" {
  source = "git::https://github.com/egarbi/terraform-aws-es-cluster"

  name                      = "example"
  vpc_id                    = "vpc-xxxxx"
  subnet_ids                = [ "subnet-one","subnet-two"]
  zone_id                   = "ZA863HSKDDD9"
  itype                     = "m4.large.elasticsearch"
  ingress_allow_cidr_blocks = [ "10.20.0.0/16", "10.22.0.0/16" ]
}
```
