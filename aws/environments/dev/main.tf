provider "aws" {
  region  = "us-east-1"
  version = "1.35.0"
  # Best practice: create separate accounts for each environment (dev, test, prod)
  # and pin the environment terraform config to the account id.
  allowed_account_ids = ["366425516243"]
}

terraform {
  backend "s3" {
    bucket = "chariot-tf-examples-dev-tf"

    # Dynamodb table is used for state locking.
    dynamodb_table = "chariot-tf-examples-dev-tf"
    key            = "terraform.tfstate"
    region         = "us-east-1"
  }

  required_version = ">= 0.11.8"
}

module "storage" {
  source          = "../../modules/storage"
  aws_region      = "${var.aws_region}"
  environment     = "${var.environment}"
  red_black       = "${var.red_black}"
  tag_name_prefix = "${var.tag_name_prefix}"
}

module "foosys" {
  source = "../../modules/foosys"
  environment     = "${var.environment}"
  red_black       = "${var.red_black}"
  tag_name_prefix = "${var.tag_name_prefix}"
  vpc_id          = "${var.main_vpc_id}"
}
