variable "env_name" {
  type        = string
  description = "VPC network & subnet name"
}

variable "zone" {
  type        = string
  description = "Zone"
}

variable "cidr" {
  type        = list(string)
  description = "v4_cidr_blocks"
}
