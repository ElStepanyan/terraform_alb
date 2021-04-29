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

resource "aws_key_pair" "key" {
  key_name   = "tr_key"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDNUdgsdAPaN0+n0cSaxy8REXkNBHUw1XaZLWSOKdT4ycv0LN8VqMU78Herbayn/hIHAv87L/Ii+rs0/FX7doykyjz8l4OTcJbP6TNPd1xQyqmdBYwajGHZhdi2YM+tjTCS33SlqoxxGVHiiV+XAOsmDzyVdJ04ZhB+P2G77tAOcjXZ+4GaEtAC2/Ut6Uc5tL9HgLmUa1dJH3zxypjjCT00imZ1V9nDAzbK0bo8DggJ05pYLxX+6mmEn0gx8UxFNJU6wiVKIZAT15tQrqOZZGvGSf8slkRsw1Ja0lalm5WFLEDJhsxMOzadEJa5fSOYWUwv5dqZN6FWX30vktqpKVixzs6rXebBFlt6Un7+kRjjnti70ETX5a1zdKDxhbhqfV6bS0CxsbI1UDZmCZ/Y1E+0IBMmbTQv+S63/3D9jWDFvan2nzsxiYCPKJW7d8/Pgflbqu3yBrhXN/76ssfKdfnoT191GZJ8VifPApTsAqhskgYfO92Y7K4grrXcJVraqJU= elush@homework"
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


