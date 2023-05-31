# Leave the first part of the block unchanged and create our `local-exec
` provisioner
provisioner "local-exec" {
command = "chmod 600 ${local_file.private_key_pem.filename}"
}
provisioner "remote-exec" {
inline = [
"sudo rm -rf /tmp",
"sudo git clone https://github.com/hashicorp/demo-terraform-101 /tmp
",
"sudo sh /tmp/assets/setup-web.sh",
]
}
tags = {
Name = "Web EC2 Server"
}
lifecycle {
ignore_changes = [security_groups]
}
}



