variable "cidr_block" {
  type = string
}

variable "pub_subnet_cidr" {
  type = list(string)
}

variable "priv_subnet_cidr" {
  type = list(string)
}

variable "pub_zones" {
  type = list(string)
}

variable "priv_zones" {
  type = list(string)
}