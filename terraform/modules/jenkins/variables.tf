variable "aws_vpc_id" {
  type = string
}

variable "allowed_http_cidr" {
  type = list(string)
}

variable "public_key" {
  type = string
}
variable "ami_id" {
  type = string
  description = "Must be a ubuntu type"
}
variable "instance_type" {
  type = string
}
variable "subnet_id" {
  type = string
}

variable "ansible_sg_id" {
  type = string 
}
