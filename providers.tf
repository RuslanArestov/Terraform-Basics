terraform {  

    backend "s3" {
    
    #shared_credentials_files = ["~/.aws/credentials"]
    # shared_config_files = [ "~/.aws/config" ]
    # profile = "default"
    
  
    endpoints ={ s3 = "https://storage.yandexcloud.net" }
    bucket     = "bucket-netology"
    key = "terraform.tfstate"
    region="ru-central1"

     # access_key и secret_key для подключения к S3 передаются в консоли при выполнении terraform init
  
    skip_region_validation      = true
    skip_credentials_validation = true
    skip_requesting_account_id  = true # Необходимая опция Terraform для версии 1.6.1 и старше.
    skip_s3_checksum            = true # Необходимая опция при описании бэкенда для Terraform версии 1.6.3 и старше.
   

    dynamodb_endpoint = "https://docapi.serverless.yandexcloud.net/ru-central1/b1ga19bdjsqdlb76sg23/etnugloob057av1igha0"
    dynamodb_table   = "tfstate_lock_table"
  }

  required_version = ">= 1.3.0"

  required_providers {
    yandex = {
      source  = "yandex-cloud/yandex"
      version = "> 0.9"
    }

    aws = {
      source  = "hashicorp/aws"
      version = "> 5.1"
    }

    random = {
      source  = "hashicorp/random"
      version = "> 3.5"
    }
  }
}


provider "aws" {
  region                      = "us-east-1"
  skip_credentials_validation = true
  skip_requesting_account_id  = true
  skip_metadata_api_check     = true
  }

provider "yandex" {
  zone      = "ru-central1-a"
}

# provider "vault" {
#  address = "http://192.168.3.239:8200"
#  skip_tls_verify = true
#  token = var.vault_root_token
# }


# terraform init -backend-config="access_key=<открытая часть статического ключа sa>" -backend-config="secret_key=<закрытая часть статического ключа sa>"
