resource "random_id" "myrandomid" {
  byte_length = 2
}

/* S3 Bucket Creation */

resource "aws_s3_bucket" "mys3bucket" {
  bucket = "${var.mys3bucket_name}-${random_id.myrandomid.dec}"
  force_destroy = "true"
  tags = {
    Name        = "${var.mys3bucket_name}-${random_id.myrandomid.dec}"
  }
}

