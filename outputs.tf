output "es_endpoint" {
  value = "${aws_elasticsearch_domain.es.endpoint}"
}

output "es_arn" {
  value = "${aws_elasticsearch_domain.es.arn}"
}

output "es_domain_id" {
  value = "${aws_elasticsearch_domain.es.domain_id}"
}

output "es_kibana_endpoint" {
  value = "${aws_elasticsearch_domain.es.kibana_endpoint}"
}

output "es_availability_zones_ids" {
  value = "${aws_elasticsearch_domain.es.vpc_options.0.availability_zones}"
}

output "es_vpc_ids" {
  value = "${aws_elasticsearch_domain.es.vpc_options.0.vpc_id}"
}

output "es_sg" {
  value = "${aws_security_group.elasticsearch.id}"
}
