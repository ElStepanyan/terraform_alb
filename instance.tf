resource "aws_security_group" "allow_ssh" {
  name        = "allow_ssh"
  description = "Allow SSH inbound traffic"
  vpc_id      = aws_vpc.tr_vpc.id

  ingress {
    description      = "SSH from VPC"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  tags = {
    Name = "tf"
  }
}

resource "aws_security_group" "allow_http" {
  name        = "allow_http"
  description = "Allow HTTP inbound traffic"
  vpc_id      = aws_vpc.tr_vpc.id

  ingress {
    description      = "HTTP from VPC"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  tags = {
    Name = "tf"
  }
}

variable "SSH_KEY" {
  type = string
}


resource "aws_key_pair" "key" {
  key_name   = "tr_key"
  public_key = var.SSH_KEY
}

resource "aws_instance" "wp_1" {
  ami           = "ami-0ca5c3bd5a268e7db"
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.tr_subnet_1.id
  vpc_security_group_ids = [aws_security_group.allow_ssh.id, aws_security_group.allow_http.id]
  key_name = "tr_key" 

  credit_specification {
    cpu_credits = "unlimited"
  }

  tags = {
    Name = "tf"
  }
}

resource "aws_instance" "wp_2" {
  ami           = "ami-0ca5c3bd5a268e7db"
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.tr_subnet_2.id
  vpc_security_group_ids = [aws_security_group.allow_ssh.id, aws_security_group.allow_http.id]
  key_name = "tr_key"

  credit_specification {
    cpu_credits = "unlimited"
  }

  tags = {
    Name = "tf"
  }
}


