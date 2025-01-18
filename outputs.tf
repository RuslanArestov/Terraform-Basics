# Используем outputs модуля vpc для импорта в модули с ВМ
output "vpc_id" {
  value = module.vpc.vpc_id
}

output "subnet_id" {
  value = module.vpc.subnet_ids
}

output "bucket_name" {
  description = "The name of the bucket."
  value       = module.s3.bucket_name
}

#Выводим секрет из Vault
output "vault_example" {
 value = "${nonsensitive(data.vault_generic_secret.vault_example.data)}"
} 