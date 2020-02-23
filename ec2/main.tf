resource "aws_instance" "myserver" {
  ami           = "ami-0a887e401f7654935"
  instance_type = "${var.instance_type}"
  vpc_security_group_ids = ["${var.vpcsgid}"]
  subnet_id = "${var.subnetid}"
  key_name = "${var.keyname}"
    tags {
        Name = "${var.myserver_name}"
    }

}
