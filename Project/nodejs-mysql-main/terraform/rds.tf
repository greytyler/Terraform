/*

1. rds tf resource
2. security group
    - 3306
        - security-grp => tf_ec2_sg
        - cidr_block => ["local_ip"]
3. outputs
*/

# rds resource
resource "aws_db_instance" "tf_rds_instance" {
  allocated_storage         = 10
  db_name               = "grey_demo"
  identifier = "nodejs-rds-mysql"
  engine                = "mysql"
    engine_version        = "8.0"
    instance_class      = "db.t3.micro"
    username             = "admin"
    password             = "grey_123"
    parameter_group_name = "default.mysql8.0"
    skip_final_snapshot = true
    publicly_accessible = true
    vpc_security_group_ids = [aws_security_group.tf_rds_sg.id] # security group module
  
}


# security group
resource "aws_security_group" "tf_rds_sg" {

  name        = "allow_mysql"
  description = "Allow mysql traffic"
  vpc_id      = "vpc-04fa6265d1f9e96be" # default vpc

  ingress {
    description = "TCP"
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = ["165.16.166.152/32"] #local ip
  }

  ingress {
    description = "TCP"
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    security_groups = [module.tf_module_ec2_sg.security_group_id] # allow allow all from ec2 security group
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]  # allow all outbound traffic to anywhere
  }

}

# local 
locals {
    rds_endpoint = element(split(":", aws_db_instance.tf_rds_instance.endpoint), 0)
}

# output
output "rds_endpoint" {
    value = local.rds_endpoint
}

output "rds_username" {
    value = aws_db_instance.tf_rds_instance.username
  
}

output "db_name" {
    value = aws_db_instance.tf_rds_instance.db_name
  
}

# connect to the db from the cmd: >mysql -h nodejs-rds-mysql.c4j82awmoz78.us-east-1.rds.amazonaws.com -u admin -p 
