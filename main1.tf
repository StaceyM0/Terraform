terraform {
required_version = ">= 1.0.0"
required_providers {
aws = {
source = "hashicorp/aws"
version = "~> 3.0"
}
http = {
source = "hashicorp/http"
version = "2.1.0"
}
random = {
source = "hashicorp/random"
version = "3.1.0"
}
local = {
source = "hashicorp/local"
version = "2.1.0"
}
tls = {
source = "hashicorp/tls"
version = "3.1.0"
}
}

variable "num_1" {
type = number
description = "Numbers for function labs"
default = 88
}
variable "num_2" {
type = number
description = "Numbers for function labs"
default = 73
}
variable "num_3" {
type = number
description = "Numbers for function labs"
default = 52
}