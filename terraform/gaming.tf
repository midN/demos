variable "aws_profile" {
  type = "string"
  default = "default"
}

variable "aws_region" {
  type = "string"
  default = "eu-central-1"
}

variable "ami" {
  type = "string"
  default = "g2_awtf_gaming"
}

variable "aws_vpc" {
  type = "string"
}

variable "aws_subnet" {
  type = "string"
}

provider "aws" {
  region = "${var.aws_region}"
  profile = "${var.aws_profile}"
}

data "aws_ami" "awtf_g2" {
  most_recent = true
  filter {
    name = "name"
    values = ["${var.ami}"]
  }
}

data "http" "icanhazip" {
   url = "http://icanhazip.com"
}

resource "aws_security_group" "awtf" {
  vpc_id = "${var.aws_vpc}"
  name = "awtf"

  ingress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["${chomp(data.http.icanhazip.body)}/32"]
  }

  egress {
      from_port = 0
      to_port = 0
      protocol = "-1"
      cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_spot_instance_request" "awtf" {
    spot_price = "1"
    ami = "${data.aws_ami.awtf_g2.id}"
    subnet_id = "${var.aws_subnet}"
    instance_type = "g2.2xlarge"

    tags {
        Name = "AWTF Gaming"
    }

    vpc_security_group_ids = ["${aws_security_group.awtf.id}"]
    associate_public_ip_address = true

    ebs_optimized = true
}
