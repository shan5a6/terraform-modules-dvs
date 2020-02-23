resource "random_id" "myrandomid" {
  byte_length = 2
}

/* S3 Bucket Creation */

variable "mys3bucket_name" {
	default = "mys3-bucket"
}
resource "aws_s3_bucket" "mys3bucket" {
  bucket = "${var.mys3bucket_name}-${random_id.myrandomid.dec}"
  force_destroy = "true"
  tags = {
    Name        = "${var.mys3bucket_name}-${random_id.myrandomid.dec}"
  }
}

output "mys3bucketname" 
{
	value = "${aws_s3_bucket.mys3bucket.id}"
}

/* VPC Creation */
variable "myvpc_name" {
	default = "myvpc"
}

variable "myvpc_cidr" {
	default = "192.166.0.0/16"
}
resource "aws_vpc" "myvpc" {
  cidr_block       = "${var.myvpc_cidr}"
  enable_dns_support = "true"
  enable_dns_hostnames = "true"
  tags = {
    Name = "${var.myvpc_name}"
  }
}

variable "myigw_name" {
	default = "myigw"
}
resource "aws_internet_gateway" "myigw" {
  vpc_id = "${aws_vpc.myvpc.id}"

  tags = {
    Name = "${var.myigw_name}"
  }
}

variable "myroute_name" {
	default = "myroute"
}
resource "aws_route_table" "myroute" {
  vpc_id = "${aws_vpc.myvpc.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.myigw.id}"
  }

  tags = {
    Name = "${var.myroute_name}"
  }
}

variable "mypubsubnet_name" {

	default = "mypubsubnet"
}

variable "mypubsubnet_cidr" {
	default = "192.166.10.0/24"
}
resource "aws_subnet" "mypubsubnet" {
  vpc_id     = "${aws_vpc.myvpc.id}"
  cidr_block = "${var.mypubsubnet_cidr}"
  map_public_ip_on_launch = "true"
  availability_zone = "us-east-1a"

  tags = {
    Name = "${var.mypubsubnet_name}"
  }
}

resource "aws_route_table_association" "myrouteassociation" {
  subnet_id = "${aws_subnet.mypubsubnet.id}"
  route_table_id = "${aws_route_table.myroute.id}"
}

variable "mysecgroup_name" {
	default = "mysecgroup"
}
resource "aws_security_group" "mysecgroup" {
  vpc_id      = "${aws_vpc.myvpc.id}"

  ingress {
    # TLS (change to whatever ports you need)
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = ["0.0.0.0/0"]
  }
  tags = {
    Name = "${var.mysecgroup_name}"
  }
}

output "myvpcname" {
	value = "${aws_vpc.myvpc.tags.Name}"
}

output "mysubnetid" {
	value = "${aws_subnet.mypubsubnet.id}"
}

output "mysgid" {
	value = "${aws_security_group.mysecgroup.id}"
}


/* Ec2 Creation */

variable "myserver_name" {
	default = "PubServer"
}

variable "keyname" {
	default = "rajukey_nvirginia"
}

variable "instance_type" {
	default = "t2.micro"
}
resource "aws_instance" "myserver" {
  ami           = "ami-0a887e401f7654935"
  instance_type = "${var.instance_type}"
  vpc_security_group_ids = ["${aws_security_group.mysecgroup.id}"]
  subnet_id = "${aws_subnet.mypubsubnet.id}"
  key_name = "${var.keyname}"
    tags {
        Name = "${var.myserver_name}"
    }

}


output "myservername" {
	value = "${aws_instance.myserver.tags.Name}"
}

output "publicip" {
	value = "${aws_instance.myserver.public_ip}"
}
