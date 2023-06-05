resource "aws_instance" "app_server" {
    ami = var.ami_id
    instance_type = var.instance_type
    tags = {
        Name = "ExampleAppServerInstance"
    }
}

variable "ami_id" {
    type = string
    default = "ami-0715c1897453cabd1"
}

variable "instance" {
    type = string 
    default = "t2.micro"
}


variable "ami_id" {
    type = string
    default = "ami-0715c1897453cabd1"
}


