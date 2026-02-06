resource "aws_security_group" "ansible-sg" {
  name        = "ansible-sg"
  vpc_id      = var.aws_vpc_id

  ingress {
    description = "ssh access"
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = var.allowed_ssh_cidr
  }
  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "ansible-sg"
  }
}

resource "aws_key_pair" "ansible-key" {
  key_name   = "ansible-key"
  public_key = var.public_key
}

resource "aws_instance" "ansible-server" {
  ami           = var.ami_id
  instance_type = var.instance_type
  subnet_id = var.subnet_id
  key_name = aws_key_pair.ansible-key.key_name
  vpc_security_group_ids = [aws_security_group.ansible-sg.id]
  associate_public_ip_address = true

  user_data = base64encode(file("userdata/setup.sh"))

  tags = {
    Name = "ansible-control-node"
  }
}