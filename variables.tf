// Required
variable "name" {
  default     = ""
  description = "Elastic Search Service cluster name."
  type        = "string"
}

variable "subnet_ids" {
  description = "List of VPC Subnet IDs for the Elastic Search Service EndPoints will be created."
  type = "list"
}

variable "vpc_id" {
  default     = ""
  description = "Vpc id where the Elastic Search Service cluster will be launched."
  type        = "string"
}

variable "zone_id" {
  default     = "Route 53 zone id where our "
  description = ""
  type        = "string"
}

// Optional
variable "access_policies" {
  default     = ""
  description = "IAM policy document specifying the access policies for the domain."
  type        = "string"
}

variable "dedicated_master" {
  default     = false
  description = "Indicates whether our cluster have dedicated master nodes enabled."
  type        = "string"
}

variable "encryption_enabled" {
  default     = "false"
  description = "Enable encription in Elastic Search."
  type        = "string"
}

variable "encryption_kms_key_id" {
  default     = ""
  description = "Enable encription in Elastic Search."
  type        = "string"
}

variable "elasticsearch_version" {
  default     = "5.5"
  description = "Elastic Search Service cluster version number."
  type        = "string"
}

variable "icount" {
  default     = 1
  description = "Elastic Search Service cluster Ec2 instance number."
  type        = "string"
}

variable "indices_fielddata_cache_size" {
  default     = ""
  description = "Percentage of Java heap space allocated to field data."
  type        = "string"
}

variable "indices_query_bool_max_clause_count" {
  default     = 1024
  description = "Maximum number of clauses allowed in a Lucene boolean query."
  type        = "string"
}

variable "ingress_allow_cidr_blocks" {
  default     = []
  description = "Specifies the ingress CIDR blocks allowed."
  type        = "list"
}

variable "ingress_allow_security_groups" {
  default     = []
  description = "Specifies the ingress security groups allowed."
  type        = "list"
}

variable "itype" {
  default     = "m4.large.elasticsearch"
  description = "Elastic Search Service cluster Ec2 instance type."
  type        = "string"
}

variable "mcount" {
  default     = 0
  description = "Elastic Search Service cluster dedicated master Ec2 instance number."
  type        = "string"
}

variable "mtype" {
  default     = ""
  description = "Elastic Search Service cluster dedicated master Ec2 instance type."
  type        = "string"
}

variable "zone_awareness" {
  default     = false
  description = "Indicates whether zone awareness is enabled."
  type        = "string"
}

variable "rest_action_multi_allow_explicit_index" {
  default     = "true"
  description = "Specifies whether explicit references to indices are allowed inside the body of HTTP requests."
  type        = "string"
}

variable "snapshot_start" {
  default     = 0
  description = "Elastic Search Service maintenance/snapshot start time."
  type        = "string"
}

variable "volume_size" {
  default     = "35"
  description = "Default size of the EBS volumes."
  type        = "string"
}

variable "volume_type" {
  default     = "gp2"
  description = "Default type of the EBS volumes."
  type        = "string"
}
