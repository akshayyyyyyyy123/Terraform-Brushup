variable "instance_count" {
  type        = number
  description = "Total number of instances"
}

variable "ami_id" {
  type = string
}

variable "instance_type" {
  type = string
}

variable "subnet_ids" {
  type = list(string)
}

variable "ssh_cidr_ip" {
  type = string
}

variable "vpc_id" {
  type = string
}