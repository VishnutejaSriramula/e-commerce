module "vpc" {
  source = "../modules/vpc"
  cidr_block = var.cidr_block
  pub_subnet_cidr = var.pub_subnet_cidr
  priv_subnet_cidr = var.priv_subnet_cidr
  pub_zones = var.pub_zones
  priv_zones = var.priv_zones
}

module "ansible" {
  source = "../modules/ansible"
  instance_type = var.instance_type
  allowed_ssh_cidr = var.allowed_ssh_cidr
  aws_vpc_id = var.aws_vpc_id
  ami_id = var.ami_id
  public_key = var.public_key
  subnet_id = var.subnet_id
}

module "jenkins" {
  source = "../modules/jenkins"
  ansible_sg_id = var.ansible_sg_id
  instance_type = var.instance_type1
  subnet_id = var.subnet_id
  allowed_http_cidr = var.allowed_http_cidr
  public_key = var.public_key
  ami_id = var.ami_id
  aws_vpc_id = var.aws_vpc_id
}