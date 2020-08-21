provider "aws" {
  version = "~> 2.0"
  region     = "ap-south-1"
  profile    = "akash"
  access_key = "AKIA6CHGFUTHHGDXTJX4"
  secret_key = "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"
}

resource "aws_key_pair" "myterrakey" {
  key_name   = "myterrakey"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQD3F6tyPEFEzV0LX3X8BsXdMsQz1x2cEikKDEY0aIj41qgxMCP/iteneqXSIFZBp5vizPvaoIR3Um9xK7PGoW8giupGn+EPuxIA4cDM4vzOqOkiMPhz5XK0whEjkVzTo4+S0puvDZuwIsdiW9mxhJc7tgBNL0cYlWSYVkz4G/fslNfRPW5mYAM49f4fhtxPb5ok4Q2Lg9dPKVHO/Bgeu5woMc7RY0p1ej6D4CKFE6lymSDJpW0YHX/wqE9+cfEauh7xZcG0q9t2ta6F6fmX0agvpFyZo8aFbXeUBr7osSCJNgvavWbM/06niWrOvYX2xwWdhXmXSrbX8ZbabVohBK41 email@example.com"
}

resource "aws_security_group" "mysecurity1" {
  name        = "mysecurity1"
  description = "Allow TLS inbound traffic"
  vpc_id      = "vpc-6fb9a407"

  ingress {
    description = "TLS from VPC"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description = "TLS from VPC"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description = "TLS from VPC"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description = "TLS from VPC"
    from_port   = 2049
    to_port     = 2049
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "mysecurity1"
  }
}

resource "aws_efs_file_system" "myefs" {
  creation_token = "myefs"
  encrypted = "true"

  tags = {
    Name = "myefs"
  }
  lifecycle_policy {
    transition_to_ia = "AFTER_30_DAYS"
  }
}
resource "aws_vpc" "myefs" {
  cidr_block = "10.0.0.0/16"
}
resource "aws_efs_mount_target" "myefs" {
  file_system_id = "${aws_efs_file_system.myefs.id}"
  subnet_id      = "subnet-c4600b88"
}

