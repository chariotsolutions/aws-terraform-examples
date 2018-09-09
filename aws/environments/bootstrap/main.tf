provider "aws" {
  region  = "us-east-1"
  version = "1.35.0"
  # Best practice: create separate accounts for each environment (dev, test, prod)
  # and pin the environment terraform config to the account id.
  allowed_account_ids = ["366425516243"]
}

resource "aws_s3_bucket" "chariot_terraform_examples_terraform" {
  bucket = "chariot-tf-examples-${var.environment}-tf"
  acl    = "private"
  region = "${var.aws_region}"

  # This only prevents Terraform from destroying the resource.
  # It does not prevent destruction from the AWS Console or API.
  # lifecycle {
  #   prevent_destroy = true
  # }

  tags {
    # If you cannot have separate AWS accounts for each environment (dev, test, prod)
    # then you should tag each resource with an environment string.
    # This can be used in various filters and in billing reports.
    Environment = "${var.environment}"
    Name = "${var.tag_name_prefix}-s3-bucket-tfstate-${var.environment}"
  }
}

resource "aws_dynamodb_table" "chariot_terraform_examples_statelock" {
  name           = "chariot-tf-examples-${var.environment}-tf"
  read_capacity  = 10
  write_capacity = 10
  hash_key       = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }

  # This only prevents Terraform from destroying the resource.
  # It does not prevent destruction from the AWS Console or API.
  # lifecycle {
  #   prevent_destroy = true
  # }

  tags {
    Environment = "${var.environment}"
    Name = "${var.tag_name_prefix}-dynamo-table-tfstate-${var.environment}"
  }
}
