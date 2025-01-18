variable "default_zone" {
  type        = string
  default     = "ru-central1-a"
  description = "https://cloud.yandex.ru/docs/overview/concepts/geo-scope"
}
variable "default_cidr" {
  type        = list(string)
  default     = ["10.0.1.0/24"]
  description = "https://cloud.yandex.ru/docs/vpc/operations/subnet-create"
}

variable "vpc_name" {
  type        = string
  default     = "develop"
  description = "VPC network&subnet name"
}

###common vars

variable "first-vm_name" {
  type        = string
  default     = "first-vm"
}

variable "second-vm_name" {
  type        = string
  default     = "second-vm"
}

variable "image_family" {
  type        = string
  default     = "ubuntu-2004-lts"
}

variable "public_ip" {
  type    = bool
  default = true
}
  
variable "owner_name" {
  type        = string
  default     = "r.arestov"
}

variable "project_first_name" {
  type        = string
  default     = "marketing"
}

variable "project_second_name" {
  type        = string
  default     = "analytic"
}

variable "username" {
  type    = string
  default = "user_admin"
}

variable "ssh_public_key" {
  type    = string
  default = "~/.ssh/terraform_study.pub"
}

variable "packages" {
  type    = string
  default = "nginx"
}

locals {
  subnet_zones = [var.default_zone]
}

variable "vpc_name_stage" {
  type        = string
  default     = "stage"
  description = "VPC network&subnet name"
}

variable "stage_cidr" {
  type        = list(string)
  default     = ["10.0.2.0/24"]
}

variable "zone_and_cidr" {
    type = list(object({
    zone = string
    cidr = string
  }))
  default = [
    { zone = "ru-central1-a", cidr = "10.0.1.0/24" },
    { zone = "ru-central1-b", cidr = "10.0.2.0/24" },
    { zone = "ru-central1-d", cidr = "10.0.3.0/24" },
  ]
}

# Переменные для S3 бакета
variable "bucket_name" {
  description = "Имя S3 бакета"
  type        = string
  default     = "my-s3-bucket"
}

variable "max_size" {
  description = "Размер бакета"
  type        = number
  default     = 1073741824
}

#Токен для Vault
variable "vault_root_token" {
  type        = string
  sensitive   = true
}


