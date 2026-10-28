variable "environment" {
  type        = string
  default     = "dev"
  description = "The environment"
}

variable "managed_by" {
  type        = string
  default     = "Hari"
  description = "Resource"
}

variable "instance_type" {
  type       = string
  default    = "t2.micro"
  decription = "instance type"
}
