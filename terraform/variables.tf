variable "region" {
  type        = string
  default     = "us-east-1"
}

variable "ami_id" {
  type        = string
}

variable "instance_type" {
  type        = string
  default     = "t2.micro"
}

variable "key_name" {
  type        = string
}

variable "public_key" {
  type        = string
}

variable "private_key" {
  type        = string
  sensitive   = true
}