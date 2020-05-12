variable "account_name" {
  default = "appzen-dev"
}

variable "environment" {
  default = "mgmt"
}

variable "key_name" {
  description = "SSH key name to use"
  default     = "devops-2018-12-19"
}

variable "region" {
  default = "us-east-1"
}

variable "instance_type" {
  description = "AWS Instance type, if you change, make sure it is compatible with AMI, not all AMIs allow all instance types "
  default     = "m5.large"
}
