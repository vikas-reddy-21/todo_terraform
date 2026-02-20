variable "instance_type" {
  default = "t2.micro"
}

variable "key_name" {
  description = "Existing AWS key pair name"
}

variable "domain_name" {
  default = "vikastodo.com"
}
