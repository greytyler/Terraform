/*
1.  ec2 instance resource
2.  new security group
    - 22 (ssh)
    - 443 (https)
    - 3000 (nodejs) // ip:3000
*/

resource "aws_instance" "tf_ec2_instance" {
  ami                         = "ami-020cba7c55df1f615" # ubuntu image
  instance_type               = "t2.micro"
  associate_public_ip_address = true
  vpc_security_group_ids      = [module.tf_module_ec2_sg.security_group_id] # security group module
  key_name                    = "tf_greykeypair"
  depends_on                  = [aws_s3_object.tf_s3_object]
  user_data  = <<-EOF
              #!/bin/bash

              # Go to home directory
              cd /home/ubuntu

              # Git clone
              git clone https://github.com/verma-kunal/nodejs-mysql.git 

              # Enter the cloned directory
              cd nodejs-mysql

              # Install Node.js
              sudo apt update -y
              sudo apt install -y nodejs npm

              # edit env vars
              echo "DB_HOST=${local.rds_endpoint}" | sudo tee .env
              echo "DB_USER=${aws_db_instance.tf_rds_instance.username}" | sudo tee -a .env
              sudo echo "DB_PASS=${aws_db_instance.tf_rds_instance.password}" | sudo tee -a .env
              echo "DB_NAME=${aws_db_instance.tf_rds_instance.db_name}" | sudo tee -a .env
              echo "TABLE_NAME=users" | sudo tee -a .env
              echo "PORT=3000" | sudo tee -a .env

              # start server
              npm install
              EOF
  user_data_replace_on_change = true
  tags = {
    Name = "Nodejs-server"
  }
}

# security group
# resource "aws_security_group" "tf_ec2_sg" {

#   name        = "nodejs-server-sg"
#   description = "Allow SSH and HTTP traffic"
#   vpc_id      = "vpc-04fa6265d1f9e96be" # default vpc

#   ingress {
#     description = "TLS from VPC"
#     from_port   = 443 # for nodejs app
#     to_port     = 443
#     protocol    = "tcp"
#     cidr_blocks = ["0.0.0.0/0"] # allow all traffic from anywhere
#   }
#   ingress {
#     description = "SSH"
#     from_port   = 22
#     to_port     = 22
#     protocol    = "tcp"
#     cidr_blocks = ["0.0.0.0/0"]
#   }
#   ingress {
#     description = "TCP"
#     from_port   = 3000 # for nodejs app
#     to_port     = 3000
#     protocol    = "tcp"
#     cidr_blocks = ["0.0.0.0/0"] # allow all traffic from anywhere
#   }

#   egress {
#     from_port   = 0
#     to_port     = 0
#     protocol    = "-1"
#     cidr_blocks = ["0.0.0.0/0"]
#   }
# }

# ec2 security group module
module "tf_module_ec2_sg" {
  source = "terraform-aws-modules/security-group/aws"
  version = "5.2.0"
  vpc_id = "vpc-04fa6265d1f9e96be" # default vpc
  name = "tf_module_ec2_sg"

  ingress_with_cidr_blocks = [
    {
        from_port = 3000
        to_port = 3000
        protocol = "tcp"
        cidr_blocks = "0.0.0.0/0"
    },
    {
        rule = "https-443-tcp"
        cidr_blocks = "0.0.0.0/0"
    },
    {
        rule = "ssh-tcp"
        cidr_blocks = "0.0.0.0/0"
    }
  ]

  egress_rules = ["all-all"]

}

# output
output "ec2public_ip" {
  #value = aws_instance.tf_ec2_instance.public_ip
  value = "ssh -i C:/Users/Thabo/.ssh/tf_greykeypair.pem ubuntu@${aws_instance.tf_ec2_instance.public_ip}"

  
}

# ssh into my instance:  ssh -i C:\Users\Thabo\.ssh\tf_greykeypair.pem ubuntu@54.162.183.106
