# vars first VM

variable "vm_web_platform" {
  type        = string
  default     = "standard-v1"
}

variable "vm_web_name_resource" {
  type        = string
  default     = "netology-develop-platform-web"
}

variable "default_cidr" {
  type        = list(string)
  default     = ["10.0.1.0/24"]
  description = "https://cloud.yandex.ru/docs/vpc/operations/subnet-create"
}

variable "default_zone" {
  type        = string
  default     = "ru-central1-a"
  description = "https://cloud.yandex.ru/docs/overview/concepts/geo-scope"
}

variable "name_subnet_1" {
  type        = string
}

# vars second VM

variable "vm_db_platform" {
  type        = string
  default     = "standard-v1"
}

variable "vm_db_name_resource" {
  type        = string
  default     = "netology-develop-platform-db"
}

variable "subnet_for_vm_db" {
  type        = list(string)
  default     = ["10.0.2.0/24"]
}

variable "zone_for_vm_db" {
  type        = string
  default     = "ru-central1-b"
}

variable "name_subnet_2" {
  type        = string
}
