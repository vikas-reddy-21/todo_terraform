# VPC [virtual private cloud] ----------------

resource "aws_vpc" "main"{
  cidr_block="10.0.0.0/16"
}

# internet gate way to enter vpc -------------

resource "aws_internet_gateway" "igw"{
  vpc_id=aws_vpc.main.id
}

#subnets inside vpc -------------

resource "aws_subnet" "public_subnet"{
  vpc_id=aws_vpc.main.id
  cidr_block="10.0.1.0/24"
  availability_zone="ap-south-1a"
  map_public_ip_on_launch = true
}

#route table defines how traffic move in the network -----------

resource "aws_route_table" "public_route_tb"{
  vpc_id=aws_vpc.main.id
  
  route { 
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
}

# attaching this route table to this security group
resource "aws_route_table_association" "public_association"{
subnet_id=aws_subnet.public_subnet.id
route_table_id=aws_route_table.public_route_tb.id
}

#security groups for subnets --------------

resource "aws_security_group" "public_sg"{
name="my-public-sg"
description="allow-todo-traffic-into-public-subnet"
vpc_id=aws_vpc.main.id

ingress {
    from_port = 80
    to_port   = 80
    protocol  = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port = 443
    to_port   = 443
    protocol  = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port = 22
    to_port   = 22
    protocol  = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port = 0
    to_port   = 0
    protocol  = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# creating EC2 inside a subnet ------------

resource "aws_instance" "todo_web"{
  ami="ami-0f5ee92e2d63afc18"
  instance_type="t3.micro"
  key_name=var.key_name
  subnet_id=aws_subnet.public_subnet.id
  vpc_security_group_ids=[aws_security_group.public_sg.id]
  associate_public_ip_address = true
  user_data = file("userdata.sh")

  root_block_device {
    volume_size = 10
  }
}

# Elastic IP [premenant ip address for a instance]  --------
resource "aws_eip" "todo_eip" {
  domain = "vpc"

  tags = {
    Name = "todo-elastic-ip"
  }
}
# attaching elasitc ip to instance
resource "aws_eip_association" "eip_assoc" {
  instance_id   = aws_instance.todo_web.id
  allocation_id = aws_eip.todo_eip.id
}

