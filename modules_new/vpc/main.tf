provider "aws" {

        region = "${var.region}"
}

resource "aws_vpc" "myvpc" {
  cidr_block       = "${var.vpc_cidr}"
  tags = {
    Name = "${var.vpc_name}"
  }
}

resource "aws_internet_gateway" "myigw" {
  vpc_id = "${aws_vpc.myvpc.id}"

  tags = {
    Name = "${var.igw_name}"
  }
}

resource "aws_route_table" "myroute" {
  vpc_id = "${aws_vpc.myvpc.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.myigw.id}"
  }

  tags = {
    Name = "${var.route_name}"
  }
}

resource "aws_subnet" "mysub" {
  vpc_id     = "${aws_vpc.myvpc.id}"
  cidr_block = "${var.sub_cidr}"

  tags = {
    Name = "${var.sub_name}"
  }
}

resource "aws_route_table_association" "myassoc" {
  subnet_id      = "${aws_subnet.mysub.id}"
  route_table_id = "${aws_route_table.myroute.id}"
}


