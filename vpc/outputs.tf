output "myvpcname" {
        value = "${aws_vpc.myvpc.tags.Name}"
}

output "mysubnetid" {
        value = "${aws_subnet.mypubsubnet.id}"
}

output "mysgid" {
        value = "${aws_security_group.mysecgroup.id}"
}
