resource "aws_s3_bucket" "tf_examples" {
  bucket = "tf-examples-${var.environment}"
  region = "${var.aws_region}"

  acl = "private"

  lifecycle_rule {
    id      = "prefix temp/"
    prefix  = "temp/"
    enabled = true

    abort_incomplete_multipart_upload_days = 7

    transition {
      days          = 30
      storage_class = "STANDARD_IA"
    }

    expiration {
      days = 90
    }
  }

  tags {
    Environment = "${var.environment}"
    Name = "${var.tag_name_prefix}-s3-bucket-storage-${var.environment}-${var.red_black}"
  }
}
