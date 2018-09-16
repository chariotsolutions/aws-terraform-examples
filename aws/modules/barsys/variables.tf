variable "ansible_wait_sec" {
  default = 30
}

variable "aws_linux_2_amis" {
  type = "map"

  default = {
    # This is a map of the Amazon Linux 2 AMIs.
    # The same Amazon Linux version has different AMI ids across regions.
    # See https://aws.amazon.com/amazon-linux-2/release-notes/
    # AMIs are Amazon Linux HVM (SSD) EBS backed versions.
    "us-east-1" = "ami-00b94673edfccb7ca"
    "us-west-2" = "ami-99dafbe1"
  }
}

variable "environment" {
  type = "string"
}

variable "red_black" {
  type = "string"
}

variable "region" {
  type = "string"
}

variable "ssh_key_name" {
  type = "string"
}

variable "ssh_key_path" {
  type = "string"
}

variable "tag_name_prefix" {
  type = "string"
}

variable "vpc_id" {
  type = "string"
}
