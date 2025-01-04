resource "yandex_vpc_network" "develop" {
  name = var.vpc_name
}
resource "yandex_vpc_subnet" "develop" {
  name           = var.name_subnet_1
  zone           = var.default_zone
  network_id     = yandex_vpc_network.develop.id
  v4_cidr_blocks = var.default_cidr
  route_table_id = yandex_vpc_route_table.rt.id
}

resource "yandex_vpc_subnet" "zone_vm_db" {
  name           = var.name_subnet_2
  zone           = var.zone_for_vm_db
  network_id     = yandex_vpc_network.develop.id
  v4_cidr_blocks = var.subnet_for_vm_db
  route_table_id = yandex_vpc_route_table.rt.id
}

data "yandex_compute_image" "ubuntu" {
  family = var.vm_web_image_family 
}
resource "yandex_compute_instance" "platform" {
  name        = local.vm_web_name
  platform_id = var.vm_web_platform
  zone        = var.default_zone
  resources {
    cores         = var.vms_resources.web.cores
    memory        = var.vms_resources.web.memory
    core_fraction = var.vms_resources.web.core_fraction
  }
  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.image_id
      size     = var.vms_resources.web.hdd_size
      type     = var.vms_resources.web.hdd_type
    }
  }
  scheduling_policy {
    preemptible = true
  }
  network_interface {
    subnet_id = yandex_vpc_subnet.develop.id
    nat       = false
  }

  #metadata = {
  #  serial-port-enable = 1
  #  ssh-keys           = "ubuntu:${var.vms_ssh_root_key}"
  #}

  metadata = var.metadata
}

resource "yandex_compute_instance" "db" {
  name        = local.vm_db_name
  platform_id = var.vm_db_platform
  zone           = var.zone_for_vm_db
  resources {
    cores         = var.vms_resources.db.cores
    memory        = var.vms_resources.db.memory
    core_fraction = var.vms_resources.db.core_fraction
  }
  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.image_id
      size     = var.vms_resources.db.hdd_size
      type     = var.vms_resources.db.hdd_type
    }
  }
  scheduling_policy {
    preemptible = true
  }
  network_interface {
    subnet_id = yandex_vpc_subnet.zone_vm_db.id
    nat       = false
  }

  #metadata = {
  #  serial-port-enable = 1
  #  ssh-keys           = "ubuntu:${var.vms_ssh_root_key}"
  #}

  metadata = var.metadata
}

#######nat_gateway#######

resource "yandex_vpc_gateway" "nat_gateway" {
  folder_id      = var.folder_id 
  name = "test-gateway"
  shared_egress_gateway {}
}

resource "yandex_vpc_route_table" "rt" {
  folder_id      = var.folder_id
  name       = "test-route-table"
  network_id = yandex_vpc_network.develop.id

  static_route {
    destination_prefix = "0.0.0.0/0"
    gateway_id         = yandex_vpc_gateway.nat_gateway.id
  }
}