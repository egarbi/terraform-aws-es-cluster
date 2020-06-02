AWS Elasticsearch Service Terraform Module
==========================================

Usage:

```hcl
data "aws_region" "current" {}

data "aws_caller_identity" "current" {}

module "es-cluster" {
  source = "git::https://github.com/egarbi/terraform-aws-es-cluster"

  name                      = "example"
  vpc_id                    = "vpc-xxxxx"
  subnet_ids                = [ "subnet-one" ]
  zone_id                   = "ZA863HSKDDD9"
  itype                     = "m4.large.elasticsearch"
  ingress_allow_cidr_blocks = [ "10.20.0.0/16", "10.22.0.0/16" ]
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
```

 Note On Multi-AZ Support:<br>
 AWS Supports up to 3 AZ's for a multi-az configuration. Understand that if you operate in more than 3 AZ's and you choose to deploy master nodes, only 3 AZ's will be supported and any more than that may result in TF returning AWS API errors.<br> 
 For more information see [here](https://docs.aws.amazon.com/elasticsearch-service/latest/developerguide/es-managedomains-dedicatedmasternodes.html)

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| access\_policies | IAM policy document specifying the access policies for the domain. | string | `""` | no |
| create\_iam\_service\_linked\_role | Control the creation of the default service role, set it to false if you have already created it. | bool | true | no |
| dedicated\_master | Indicates whether our cluster have dedicated master nodes enabled. | string | `"false"` | no |
| elasticsearch\_version | Elastic Search Service cluster version number. | string | `"5.5"` | no |
| encryption\_enabled | Enable encription in Elastic Search. | string | `"false"` | no |
| encryption\_kms\_key\_id | Enable encription in Elastic Search. | string | `""` | no |
| icount | Elastic Search Service cluster Ec2 instance number. | string | `"1"` | no |
| indices\_fielddata\_cache\_size | Percentage of Java heap space allocated to field data. | string | `""` | no |
| indices\_query\_bool\_max\_clause\_count | Maximum number of clauses allowed in a Lucene boolean query. | string | `"1024"` | no |
| ingress\_allow\_cidr\_blocks | Specifies the ingress CIDR blocks allowed. | list | `<list>` | no |
| ingress\_allow\_security\_groups | Specifies the ingress security groups allowed. | list | `<list>` | no |
| itype | Elastic Search Service cluster Ec2 instance type. | string | `"m4.large.elasticsearch"` | no |
| mcount | Elastic Search Service cluster dedicated master Ec2 instance number. | string | `"0"` | no |
| mtype | Elastic Search Service cluster dedicated master Ec2 instance type. | string | `""` | no |
| name | Elastic Search Service cluster name. | string | n/a | yes |
| rest\_action\_multi\_allow\_explicit\_index | Specifies whether explicit references to indices are allowed inside the body of HTTP requests. | string | `"true"` | no |
| snapshot\_start | Elastic Search Service maintenance/snapshot start time. | string | `"0"` | no |
| subnet\_ids | List of VPC Subnet IDs for the Elastic Search Service EndPoints will be created. | list | n/a | yes |
| volume\_size | Default size of the EBS volumes. | string | `"35"` | no |
| volume\_type | Default type of the EBS volumes. | string | `"gp2"` | no |
| vpc\_id | Vpc id where the Elastic Search Service cluster will be launched. | string | n/a | yes |
| zone\_awareness | Indicates whether zone awareness is enabled. | string | `"false"` | no |
| zone\_id | Route 53 zone id where the DNS record will be created. | string | `""` | no |

## Outputs
| Name | Description |
|------|-------------|
| es\_arn | Amazon Resource Name (ARN) of the domain |
| es\_availability\_zones\_ids | If the domain was created inside a VPC, the names of the availability zones the configured subnet_ids were created inside. |
| es\_domain\_id | Unique identifier for the domain. |
| es\_endpoint | Domain-specific endpoint used to submit index, search, and data upload requests. |
| es\_kibana\_endpoint | Domain-specific endpoint for kibana without https scheme. |
| es\_sg | The SG id created to allow communication with ElasticSearch cluster. |
| es\_vpc\_ids | The VPC ID if the domain was created inside a VPC. |
