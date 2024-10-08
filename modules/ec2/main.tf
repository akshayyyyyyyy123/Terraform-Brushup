# ec2 
resource "aws_instance" "my_ec2" {
  count         = var.instance_count
  ami           = var.ami_id
  instance_type = var.instance_type
  subnet_id     = element(var.subnet_ids, count.index)

  # Attach the security group
  vpc_security_group_ids = [aws_security_group.my_security_grp.id]

  tags = {
    Name : "akshay-terraform-${count.index + 1}"
  }
}

resource "aws_security_group" "my_security_grp" {
  vpc_id = var.vpc_id

  # ssh rule
  ingress {
    description = "Allow ssh"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.ssh_cidr_ip]
  }

  egress {
    description = "All traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name : "akshay-terraform-sg"
  }
}