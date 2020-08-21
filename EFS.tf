provider "aws" {
  version = "~> 2.0"
  region     = "ap-south-1"
  profile    = "akash"  
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

