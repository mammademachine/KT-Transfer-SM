provider "aws" {
  region = "${var.region}"
  shared_credentials_file = "~/.aws/crednetials"
  profile = "terraform"
}
# resource "aws_eip" "lb" {
#  instance = "${aws_instance.web.id}"
#  vpc      = true
# }
resource "aws_instance" "coolInstnace" {
  ami = "ami-ba547fc3"
  instance_type = "t1.micro"
  private_ip = "10.0.0.12"
  subnet_id  = "${aws_subnet.tf_test_subnet.id}"
  tags = {
      Name = "StefanVM"
  }
}
resource "aws_vpc" "default" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_hostnames = true
}

resource "aws_internet_gateway" "coolGw" {
  vpc_id = "${aws_vpc.default.id}"
}

resource "aws_subnet" "tf_test_subnet" {
  vpc_id                  = "${aws_vpc.default.id}"
  cidr_block              = "10.0.0.0/24"
  map_public_ip_on_launch = true

  depends_on = ["aws_internet_gateway.coolGw"]
}

resource "aws_eip" "bar" {
  vpc = true
  instance                  = "${aws_instance.coolInstnace.id}"
  associate_with_private_ip = "10.0.0.12"
  depends_on                = ["aws_internet_gateway.coolGw"]
}