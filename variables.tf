###cloud vars
/*variable "token" {
  type        = string
  description = "OAuth-token; https://cloud.yandex.ru/docs/iam/concepts/authorization/oauth-token"
}

variable "cloud_id" {
  type        = string
  description = "https://cloud.yandex.ru/docs/resource-manager/operations/cloud/get-id"
}

variable "folder_id" {
  type        = string
  description = "https://cloud.yandex.ru/docs/resource-manager/operations/folder/get-id"
}*/

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

variable "vm_web_image_family" {
  type        = string
  default     = "ubuntu-2004-lts"
}

variable "vm_platform" {
  type        = string
  default     = "standard-v1"
}

variable "type_storage" {
  type        = string
  default     = "network-hdd"
}

variable "core_fraction" {
  type        = number
  default     = 5
}

#vm_db
variable "each_vm" {
  type = list(object({
    vm_name       = string
    cpu           = number
    core_fraction = number
    ram           = number
    disk_volume   = number
    type          = string
    platform_id   = string
    zone          = string
    hostname      = string
  }))
  default = [
    {
      vm_name       = "main"
      cpu           = 2
      core_fraction = 5
      ram           = 4
      disk_volume   = 15
      type          = "network-hdd"
      platform_id   = "standard-v1"
      zone          = "ru-central1-a"
      hostname      = "main-db"
    },
    {
      vm_name       = "replica"
      cpu           = 2
      core_fraction = 5
      ram           = 2
      disk_volume   = 10
      type          = "network-hdd"
      platform_id   = "standard-v1"
      zone          = "ru-central1-a"
      hostname      = "replica-db"
    }
  ]
}

variable "vm_storage" {
  type        = string
  default     = "storage"
}

variable "fqdn_vm_storage" {
  type        = string
  default     = "storage.ru-central1.internal"
}

variable "web_provision" {
  type        = bool
  default     = true
  description = "ansible provision switch variable"
}

variable "default_ingress_rules" {
  description = "Default ingress security group rules"
  type = list(object(
    {
      protocol       = string
      description    = string
      v4_cidr_blocks = list(string)
      port           = optional(number)
      from_port      = optional(number)
      to_port        = optional(number)
    }))
  default = [
    {
      protocol       = "TCP"
      description    = "разрешить входящий ssh"
      v4_cidr_blocks = ["0.0.0.0/0"]
      port           = 22
    },
    {
      protocol       = "TCP"
      description    = "разрешить входящий http"
      v4_cidr_blocks = ["0.0.0.0/0"]
      port           = 80
    },
    {
      protocol       = "TCP"
      description    = "разрешить входящий https"
      v4_cidr_blocks = ["0.0.0.0/0"]
      port           = 443
    },
  ]
}

variable "default_egress_rules" {
  description = "Default egress security group rules"
  type = list(object(
    {
      protocol       = string
      description    = string
      v4_cidr_blocks = list(string)
      port           = optional(number)
      from_port      = optional(number)
      to_port        = optional(number)
    }))
  default = [
    {
      protocol       = "TCP"
      description    = "разрешить весь исходящий трафик"
      v4_cidr_blocks = ["0.0.0.0/0"]
      from_port      = 0
      to_port        = 65365
    }
  ]
}
