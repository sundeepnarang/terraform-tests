variable "key_name" {}

provider "aws" {
  profile    = "sundeep"
  region     = "us-west-1"
}

resource "tls_private_key" "example" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "generated_key" {
  key_name   = var.key_name
  public_key = tls_private_key.example.public_key_openssh
}


resource "aws_instance" "example" {
  ami = "ami-076e6542"
  instance_type = "t2.micro"
  associate_public_ip_address = true
  tags = {
    Name = "sundeepnarang.com"
  }
}


resource "aws_instance" "example2" {
  ami = "ami-0dd655843c87b6930"
  instance_type = "t2.nano"
  key_name      = aws_key_pair.generated_key.key_name
  tags = {
    Name = "temp_instance"
  }
}

resource "aws_eip" "ip" {
  vpc = true
  instance = aws_instance.example.id
}

output "generated_key" {
  value = tls_private_key.example.private_key_pem
}

output "ip" {
  value = aws_instance.example2.public_ip
}


