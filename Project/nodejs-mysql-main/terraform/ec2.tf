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
  vpc_security_group_ids = [aws_security_group.tf_ec2_sg.id]
  key_name = "tf_greykeypair"

  tags = {
    Name = "Nodejs-server"
  }
}

# security group
resource "aws_security_group" "tf_ec2_sg" {

  name        = "nodejs-server-sg"
  description = "Allow SSH and HTTP traffic"
  vpc_id = "vpc-04fa6265d1f9e96be" # default vpc

  ingress {
    description = "TLS from VPC"  
    from_port   = 443    # for nodejs app
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # allow all traffic from anywhere
  }
  ingress {
    description = "SSH"  
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] 
  }
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

# ssh into my instance:  ssh -i C:\Users\Thabo\.ssh\tf_greykeypair.pem ubuntu@3.80.35.223