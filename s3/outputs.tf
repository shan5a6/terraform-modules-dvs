output "mys3bucketname"
{
        value = "${aws_s3_bucket.mys3bucket.id}"
}
