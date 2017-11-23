// Required
variable "name" {}
variable "vpc_id" {}
variable "subnet_ids" {
  type = "list"
}
variable "zone_id" {}


// Optional
variable "version" {
  default = "5.5"
}

variable "itype" {
  default = "m4.large.elasticsearch"
}

variable "icount" {
  default = 1
}

variable "dedicated_master" {
  default = false
}

variable "mtype" {
  default = ""
}

variable "mcount" {
  default = 0
}

variable "zone_awareness" {
  default = false
}

variable "ingress_allow_security_groups" {
  default = []
}

variable "ingress_allow_cidr_blocks" {
  default = []
}

variable "rest_action_multi_allow_explicit_index" {
  default = "true"
}
variable "indices_fielddata_cache_size" {
  default = ""
}

variable "indices_query_bool_max_clause_count" {
  default = 1024
}

variable "snapshot_start" {
  default = 0
}


resource "aws_security_group" "elasticsearch" {
  name        = "${var.name}"
  description = "Security Group to allow traffic to ElasticSearch"

   ingress {
    from_port       = 443
    to_port         = 443
    protocol        = "tcp"
    cidr_blocks     = ["${var.ingress_allow_cidr_blocks}"]
  }

  ingress {
    from_port       = 443
    to_port         = 443
    protocol        = "tcp"
    security_groups = ["${var.ingress_allow_security_groups}"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  vpc_id = "${var.vpc_id}"
}

resource "aws_elasticsearch_domain" "es" {
  domain_name           = "${var.name}"
  elasticsearch_version = "${var.version}"

  cluster_config {
    instance_type = "${var.itype}"
    instance_count = "${var.icount}"
    dedicated_master_enabled = "${var.dedicated_master}"
    dedicated_master_type   = "${var.mtype}"
    dedicated_master_count = "${var.mcount}"
    zone_awareness_enabled = "${var.zone_awareness}"
  }

  vpc_options {
    security_group_ids = [ "${aws_security_group.elasticsearch.id}" ]
    subnet_ids         = [ "${var.subnet_ids}" ]
  }

  advanced_options {
    "rest.action.multi.allow_explicit_index" = "${var.rest_action_multi_allow_explicit_index}"
    "indices.fielddata.cache.size" = "${var.indices_fielddata_cache_size}"
    "indices.query.bool.max_clause_count" = "${var.indices_query_bool_max_clause_count}"
  }

  ebs_options {
    ebs_enabled = true
    volume_type = "gp2"
    volume_size = "35"
  }

  snapshot_options {
    automated_snapshot_start_hour = "${var.snapshot_start}"
  }

  tags {
    Domain = "${var.name}"
  }
}

# Add ALB record on DNS
resource "aws_route53_record" "main" {
  zone_id = "${var.zone_id}"
  name    = "${var.name}"
  type    = "CNAME"
  ttl     = "300"

  records = ["${aws_elasticsearch_domain.es.endpoint}"]
}

output "es_endpoint" {
  value = "${aws_elasticsearch_domain.es.endpoint}"
}
