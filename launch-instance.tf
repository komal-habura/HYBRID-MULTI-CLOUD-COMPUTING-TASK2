provider "aws" {
  version = "~> 2.0"
  region     = "ap-south-1"
  profile    = "akash"  
}
//about the instance

resource "aws_instance" "myin" {
  ami             = "ami-0447a12f28fddb066"
  instance_type   = "t2.micro"
  key_name        = "myterrakey"
  security_groups = [ "mysecurity1" ]

  tags = {
    Name = "linuxos2"
  }
  connection {
    type     = "ssh"
    user     = "ec2-user"
    private_key = file("C:/Users/user/Downloads/myterrakey.pem")
    host     = aws_instance.myin.public_ip
   }
   provisioner "remote-exec" {
    inline = [
      "sudo yum install httpd  php git -y",
      "sudo systemctl restart httpd",
      "sudo systemctl enable httpd",
    ]
  }
}

//print the output

output "myout1" {
  value = aws_instance.myin.public_ip
}



resource "null_resource" "nullremote3"  {

  connection {
    type     = "ssh"
    user     = "ec2-user"
    private_key = file("C:/Users/user/Downloads/myterrakey.pem")
    host     = aws_instance.myin.public_ip
  }

provisioner "remote-exec" {
    inline = [
      "sudo yum install -y amazon-efs-utill",
      "sudo mount -t efs -o tls fs-fcff6e2d /var/www/html",
      "sudo rm -rf /var/www/html/*",
      "sudo git clone https://github.com/komal-habura/hybrid-cloud-project.git /var/www/html/"
    ]
  }
}
resource "aws_s3_bucket" "mybucket-terra" {
  bucket = "s3-website-test.hashicorp.com"
  acl    = "public-read"

  tags = {
    Name        = "mybucket-terra"
  }
}





