provider "aws" {

	region = "${var.region}"
}

resource "aws_instance" "myec2" {
  ami           = "${var.myami}"
  instance_type = "${var.servertype}"
  key_name = "${var.mykeyname}"
  tags = {
    Name = "${var.servername}"
  }
}
