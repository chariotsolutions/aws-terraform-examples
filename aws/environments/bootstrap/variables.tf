variable "aws_region" {
  type = "string"
  default = "us-east-1"
  description = "AWS region"
}

variable "environment" {
  type = "string"
  description = "Environment name, e.g. 'dev', 'test', 'prod', etc..."
}

variable "tag_name_prefix" {
  default = "tf-examples"
  description = "Tag 'Name' prefix"
}
