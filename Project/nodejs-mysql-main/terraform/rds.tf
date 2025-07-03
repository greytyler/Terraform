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
    password             = "grey123"
    parameter_group_name = "default.mysql8.0"
    skip_final_snapshot = true
    publicly_accessible = true
    #vpc_security_group_ids = []
  
}


# security group
resource "aws_security_group" "rds_sg" {

  name        = "allow_mysql"
  description = "Allow mysql traffic"
  vpc_id      = "vpc-04fa6265d1f9e96be" # default vpc

  ingress {
    description = "TCP"
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = ["192.168.18.6"] #local ip
    security_groups = [aws_security_group.tf_ec2_sg.id] # allow allow all from ec2 security group
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]  # allow all outbound traffic to anywhere
  }

}