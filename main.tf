provider "aws" {
  region = "eu-west-1"
  shared_credentials_file = "~/.aws/crednetials"
  profile = "terraform"
}
resource "aws_instance" "coolInstnace" {
  ami = "ami-0e55e373"
  instance_type = "t1.micro"
  tags = {
      Name = "StefanVM"
  }
}
