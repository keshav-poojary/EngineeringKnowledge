variable "instance_type" {
  type = string
  validation {
    condition = var.instance_type == "t2.micro" || var.instance_type == "t3.micro"
    error_message = "only t2 & t3 micros are allowed"
  }
}

variable "volume_size" {
  type = number
  default = 20
}

variable "volume_type" {
  type = string
  default = "gp2"
}