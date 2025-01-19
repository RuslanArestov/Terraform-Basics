# # Генерация рандомного суффикса для бакета
# resource "random_string" "unique_id" {
#   length  = 8
#   upper   = false
#   lower   = true
#   numeric = true
#   special = false
# }

#Создание сервисного аккаунта
resource "yandex_iam_service_account" "tfstate-sa" {
  name        = var.sa_name
  description = var.sa_description
}

resource "yandex_resourcemanager_folder_iam_member" "editor" {
  folder_id = var.folder_id
  role      = var.role
  member    = "serviceAccount:${yandex_iam_service_account.tfstate-sa.id}"
}

# S3-bucket
module "s3" {
  depends_on = [ yandex_iam_service_account.tfstate-sa ]
  source      = var.module_source
  bucket_name = var.bucket_name
  max_size    =  var.max_size
  versioning  = {
    enabled = var.versioning_enabled
  }

}

# Создание статического ключа для сервисного аккаунта
resource "yandex_iam_service_account_static_access_key" "sa-static-key" {
 service_account_id     = yandex_iam_service_account.tfstate-sa.id
 description            = var.sa_description
 output_to_lockbox {
   secret_id              = yandex_lockbox_secret.lockbox_secret.id
   entry_for_access_key   = var.entry_for_access_key
   entry_for_secret_key   = var.entry_for_secret_key
  }
 }

# Создание Lockbox для хранения секрета о статическом ключе
resource "yandex_lockbox_secret" "lockbox_secret" {
  name = var.lockbox_secret_name
}

# Создание YDB
resource "yandex_ydb_database_serverless" "tfstate_lock-db" {
  name       = var.ydb_database_name
  deletion_protection = var.deletion_protection

  serverless_database {
    storage_size_limit      = var.storage_size_limit
  }
}

resource "yandex_ydb_table" "tfstate_lock_table" {
  path                = var.ydb_table_name
  connection_string   = yandex_ydb_database_serverless.tfstate_lock-db.document_api_endpoint

  column {
    name     = var.ydb_column_name
    type     = var.ydb_column_type
    not_null = var.not_null
  }

  primary_key = var.ydb_primary_key

  depends_on = [yandex_ydb_database_serverless.tfstate_lock-db]
}

