# variable "default_zone" {
#   type        = string
#   default     = "ru-central1-a"
#   description = "https://cloud.yandex.ru/docs/overview/concepts/geo-scope"
# }
# variable "default_cidr" {
#   type        = list(string)
#   default     = ["10.0.1.0/24"]
#   description = "https://cloud.yandex.ru/docs/vpc/operations/subnet-create"
# }

# variable "vpc_name" {
#   type        = string
#   default     = "develop"
#   description = "VPC network&subnet name"
# }

variable "folder_id" {
  type        = string
}

###common vars

# variable "first-vm_name" {
#   type        = string
#   default     = "first-vm"
# }

# variable "second-vm_name" {
#   type        = string
#   default     = "second-vm"
# }

# variable "image_family" {
#   type        = string
#   default     = "ubuntu-2004-lts"
# }

# variable "public_ip" {
#   type    = bool
#   default = true
# }
  
# variable "owner_name" {
#   type        = string
#   default     = "r.arestov"
# }

# variable "project_first_name" {
#   type        = string
#   default     = "marketing"
# }

# variable "project_second_name" {
#   type        = string
#   default     = "analytic"
# }

# variable "username" {
#   type    = string
#   default = "user_admin"
# }

# variable "ssh_public_key" {
#   type    = string
#   default = "~/.ssh/terraform_study.pub"
# }

# variable "packages" {
#   type    = string
#   default = "nginx"
# }

# locals {
#   subnet_zones = [var.default_zone]
# }

# variable "vpc_name_stage" {
#   type        = string
#   default     = "stage"
#   description = "VPC network&subnet name"
# }

# variable "stage_cidr" {
#   type        = list(string)
#   default     = ["10.0.2.0/24"]
# }

# variable "zone_and_cidr" {
#     type = list(object({
#     zone = string
#     cidr = string
#   }))
#   default = [
#     { zone = "ru-central1-a", cidr = "10.0.1.0/24" },
#     { zone = "ru-central1-b", cidr = "10.0.2.0/24" },
#     { zone = "ru-central1-d", cidr = "10.0.3.0/24" },
#   ]
# }


# #Токен для Vault
# variable "vault_root_token" {
#   type        = string
#   sensitive   = true
# }

# Переменные для S3 бакета
# variable "bucket_name" {
#   description = "bucket-netology"
#   type        = string
# }

variable "max_size" {
  description = "Размер бакета"
  type        = number
  default     = 1073741824
}

variable "versioning_enabled" {
  description = "Включить версионирование для бакета"
  type        = bool
  default     = true
}

variable "lockbox_secret_name" {
  description = "Имя секрета в Lockbox"
  type        = string
  default     = "tfstate-lockbox-secret"
}

variable "ydb_database_name" {
  description = "Имя базы данных YDB"
  type        = string
  default     = "tfstate-lock-db"
}

# variable "ydb_table_name" {
#   description = "Имя таблицы YDB"
#   type        = string
#   default     = "tfstate_lock_table"
# }

# variable "ydb_column_name" {
#   description = "Имя колонки в таблице YDB"
#   type        = string
#   default     = "LockID"
# }

# variable "ydb_column_type" {
#   description = "Тип колонки в таблице YDB"
#   type        = string
#   default     = "string"
# }

# variable "ydb_primary_key" {
#   description = "Первичный ключ таблицы YDB"
#   type        = list(string)
#   default     = ["LockID"]
# }

# variable "aws_access_key" {
#   description = "AWS Access Key"
#   type        = string
# }

# variable "aws_secret_key" {
#   description = "AWS Secret Key"
#   type        = string
# }

variable "deletion_protection" {
  type        = bool
  default     = false
}

variable "storage_size_limit" {
  description = "Лимит хранения для базы данных YDB"
  type        = number
  default     = 1
}

# variable "not_null" {
#   description = "Не нулевое значение"
#   type        = bool
#   default     = true
# }

variable "entry_for_access_key" {
  type        = string
  default     = "access_key"
}

variable "entry_for_secret_key" {
  type        = string
  default     = "secret_key"
}

variable "sa_description_key" {
  description = "Описание сервисного аккаунта"
  type        = string
  default     = "Ключ для подключения remote tfstate"
}

variable "role" {
  description = "Роль для сервисного аккаунта"
  type        = string
  default     = "ydb.editor"
}

variable "sa_name" {
  description = "Имя сервисного аккаунта"
  type        = string
  default     = "tfstate-sa"
}

variable "sa_description" {
  type        = string
  default     = "Сервисный аккаунт для YDB"
}

variable "ip_address" {
  description = "ip-адрес"
  type        = string
  default     = "192.168.0.1"
  #default = "1920.1680.0.1"

  validation {
    condition     = can(cidrhost("${var.ip_address}/32", 0))
    error_message = "Значение IP-адреса должно быть корректным"
  }
}

variable "pool_of_ip_addresses" {
  description = "список ip-адресов"
  type        = list(string)
  default     =  ["192.168.0.1", "1.1.1.1", "127.0.0.1"]
  #default     = ["192.168.0.1", "1.1.1.1", "1270.0.0.1"]

  validation {
    condition = alltrue([
      for ip in var.pool_of_ip_addresses :
      can(cidrhost("${ip}/32", 0))
    ])
    error_message = "Одно из значений неверное"
  }
}