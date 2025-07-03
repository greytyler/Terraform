/*
1.  ec2 instance resource
2.  new security group
    - 22 (ssh)
    - 443 (https)
    - 3000 (nodejs) // ip:3000
*/

resource "aws_instance" "tf_ec2_instance" {
  ami           = "ami-020cba7c55df1f615" # ubuntu image
  instance_type = "t2.micro"
  associate_public_ip_address = true
  key_name = "tf_greykeypair"

  tags = {
    Name = "Nodejs-server"
  }
}

# Create a new security group

resource "aws_security_group" "tf_ec2_sg" {

  name        = "nodejs-server-sg"
  description = "Allow SSH and HTTP traffic"
  vpc_id = "vpc-04fa6265d1f9e96be" # default vpc

  ingress {
    description = "TCP"  
    from_port   = 3000    # for nodejs app
    to_port     = 3000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/24"] 
  }

  egress {
    from_port   = 0
    to_port     = 0 
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

} 