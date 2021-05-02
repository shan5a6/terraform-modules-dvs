provider "aws" {

        region = "${var.region}"
}

resource "random_id" "myrandomid" {
  byte_length = 2
}

resource "aws_s3_bucket" "mys3" {
  bucket = "${var.bucket_name}-${random_id.myrandomid.dec}"

  tags = {
    Name        = "${var.bucket_name}-${random_id.myrandomid.dec}"

  }
}
