variable "env_name" {
  type        = string
}
/*
variable "cidr" {
  type        = list(string)
}

variable "zone" {
  type        = string
}
*/
variable "subnets" {
  type = list(object({
    zone = string
    cidr = string
  }))
}

