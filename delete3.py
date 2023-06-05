resource "aws_instance" "app_server" {
    ami = var.ami_id
    instance_type = var.instance_type
    tags = {
        Name = "ExampleAppServerInstance"
    }
}

#!binbash 

variable "ami_id" {
    type = string
    default = "ami-0715c1897453cabd1"
}
