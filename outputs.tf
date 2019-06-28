output "es_arn" {
  description = "Amazon Resource Name (ARN) of the domain"
  value       = "${aws_elasticsearch_domain.es.arn}"
}

output "es_availability_zones_ids" {
  description = "If the domain was created inside a VPC, the names of the availability zones the configured subnet_ids were created inside."
  value       = "${aws_elasticsearch_domain.es.vpc_options.0.availability_zones}"
}

output "es_domain_id" {
  description = "Unique identifier for the domain."
  value       = "${aws_elasticsearch_domain.es.domain_id}"
}

output "es_endpoint" {
  description = "Domain-specific endpoint used to submit index, search, and data upload requests."
  value       = "${aws_elasticsearch_domain.es.endpoint}"
}

output "es_kibana_endpoint" {
  description = "Domain-specific endpoint for kibana without https scheme." 
  value       = "${aws_elasticsearch_domain.es.kibana_endpoint}"
}

output "es_sg" {
  description = "The SG id created to allow communication with ElasticSearch cluster."
  value       = "${aws_security_group.elasticsearch.id}"
}

output "es_vpc_ids" {
  description = "The VPC ID if the domain was created inside a VPC."
  value       = "${aws_elasticsearch_domain.es.vpc_options.0.vpc_id}"
}
