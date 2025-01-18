/*resource "yandex_vpc_network" "develop" {
  name = var.vpc_name
}
resource "yandex_vpc_subnet" "develop" {
  name           = var.vpc_name
  zone           = var.default_zone
  network_id     = yandex_vpc_network.develop.id
  v4_cidr_blocks = var.default_cidr
}*/

data "template_file" "userdata" {
  template = file("${path.module}/cloud-init.yml")

  vars = {
    username       = var.username
    ssh_public_key = file(var.ssh_public_key)
    packages       = var.packages
  }
}


module "marketing_vm" {
  source         = "git::https://github.com/udjin10/yandex_compute_instance.git?ref=main"
  env_name       = var.project_first_name 
  network_id     = module.vpc.vpc_id
  subnet_zones   = local.subnet_zones
  subnet_ids     = module.vpc.subnet_ids
  instance_name  = var.first-vm_name
  image_family   = var.image_family

  public_ip      = var.public_ip

  labels = { 
    owner   = var.owner_name,
    project = var.project_first_name
     }

   metadata = {
    user-data = data.template_file.userdata.rendered
  }
   
}

module "analytic_vm" {
  source         = "git::https://github.com/udjin10/yandex_compute_instance.git?ref=main"
  env_name       = var.project_second_name
  network_id     = module.vpc.vpc_id
  subnet_zones   = local.subnet_zones
  subnet_ids     = module.vpc.subnet_ids
  instance_name  = var.second-vm_name
  image_family   = var.image_family

  public_ip      = var.public_ip

  labels = { 
    owner   = var.owner_name,
    project = var.project_second_name
     }

   metadata = {
    user-data = data.template_file.userdata.rendered
  }
}

# Вторая сеть, созданная из модуля
/*module "vpc" {
  source      = "./modules/vpc"
  env_name    = var.vpc_name_stage
  cidr        = var.stage_cidr
  zone        = var.default_zone
}*/

module "vpc" {
  source      = "./modules/vpc"
  env_name    = var.vpc_name_stage
  subnets     = var.zone_and_cidr
}

# Генерация рандомного суффикса для бакета
resource "random_string" "unique_id" {
  length  = 8
  upper   = false
  lower   = true
  numeric = true
  special = false
}

# S3-bucket
module "s3" {
  source = "github.com/terraform-yc-modules/terraform-yc-s3.git"
  bucket_name = "simple-bucket-${random_string.unique_id.result}"
  max_size = 1073741824
  versioning = {
    enabled = true
  }
}

resource "local_file" "env_file" {
  content  = <<EOT
VAULT_DEV_ROOT_TOKEN_ID=${var.vault_root_token}
EOT
  filename = "${path.module}/.env"
}

provider "null" {

}

resource "null_resource" "docker_compose" {
  provisioner "local-exec" {
    command = "docker compose -f ${path.module}/docker-compose.yml up -d"
  }

  triggers = {
    always_run = "${timestamp()}"
  }
}

# Считываем секрет из Vault
data "vault_generic_secret" "vault_example"{
 path = "secret/example"
}

# Создаем секрет для Vault
resource "vault_generic_secret" "password" {
  path = "secret/password"

  data_json = jsonencode({
    pass = "I am secret!"
  })
}
