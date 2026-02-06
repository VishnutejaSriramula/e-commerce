variable "cidr_block" {
  default = "10.0.0.0/16"
}

variable "pub_subnet_cidr" {
  default = ["10.0.1.0/24","10.0.2.0/24"]
}

variable "priv_subnet_cidr" {
  default = ["10.0.3.0/24","10.0.4.0/24"]
}

variable "pub_zones" {
  default = ["us-east-1a","us-east-1c"]

}

variable "priv_zones" {
  default = ["us-east-1a","us-east-1c"]
  
}

variable "region" {
  default = "us-east-1"
}

variable "instance_type" {
  default = "t3.micro"
}

variable "allowed_ssh_cidr" {
  default = ["0.0.0.0/0"]
}

variable "aws_vpc_id" {
  default = module.vpc.vpc_id
}

variable "ami_id" {
  default = "ami-0b6c6ebed2801a5cb"
}

variable "public_key" {
  default = ""
}
variable "subnet_id" {
  default = module.vpc.subnet_id
}

variable "ansible_sg_id" {
  default = module.ansible.ansible_sg_id
}

variable "instance_type1" {
  default = ""
}
variable "allowed_http_cidr" {
  default = "0.0.0.0/0"
}