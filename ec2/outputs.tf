output "myservername" {
        value = "${aws_instance.myserver.tags.Name}"
}

output "publicip" {
        value = "${aws_instance.myserver.public_ip}"
}
