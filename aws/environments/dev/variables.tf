variable "aws_region" {
  default = "us-east-1"
}

variable "environment" {
  default = "dev"
}

variable "ssh_key_name" {
  default = "terraform-examples"
}

variable "ssh_key_path" {
  type = "string"
}

variable "main_vpc_id" {
  default = "vpc-3f96305b"
}

variable "red_black" {
  default = "r"
}

variable "tag_name_prefix" {
  default = "tf-examples"
  description = "Tag 'Name' prefix"
}
