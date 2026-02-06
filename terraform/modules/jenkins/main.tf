resource "aws_security_group" "jenkins-sg" {
  name        = "jenkins-sg"
  vpc_id      = var.aws_vpc_id

  ingress {
    description = "ssh access from ansible"
    from_port = 22
    to_port = 22
    protocol = "tcp"
    security_groups = [var.ansible_sg_id]
  }
  ingress {
    description = "Jenkins UI access"
    from_port = 8080
    to_port = 8080
    protocol = "tcp"
    cidr_blocks = var.allowed_http_cidr
  }
  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "jenkins-sg"
  }
}

resource "aws_key_pair" "jenkins-key" {
  key_name   = "jenkins-key"
  public_key = var.public_key
}

resource "aws_instance" "jenkins-server" {
  ami           = var.ami_id
  instance_type = var.instance_type
  subnet_id = var.subnet_id
  key_name = aws_key_pair.jenkins-key.key_name
  vpc_security_group_ids = [aws_security_group.jenkins-sg.id]
  associate_public_ip_address = true
  tags = {
    Name = "Jenkins-Master-node"
  }
}