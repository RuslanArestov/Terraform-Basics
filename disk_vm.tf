resource "yandex_compute_disk" "additional_disks" {
  count      = 3
  name       = "disk-${count.index + 1}"
  type       = var.type_storage
  zone       = var.default_zone
  size       = 1
}

resource "yandex_compute_instance" "storage" {
  name        = var.vm_storage
  platform_id = var.vm_platform
  zone        = var.default_zone
  hostname    = var.fqdn_vm_storage

  resources {
    core_fraction = var.core_fraction
    cores  = 2
    memory = 2
  }

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.image_id
      size      = 10
      type      = var.type_storage
    }
  }

  dynamic "secondary_disk" {
    for_each = yandex_compute_disk.additional_disks[*]
    content {
      disk_id = secondary_disk.value.id
      auto_delete = true
    }
  }

  scheduling_policy {
    preemptible = true
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.develop.id
    nat = true
  }

  metadata = {
  serial-port-enable = 1
  ssh-keys           = "ubuntu:${local.ssh_public_key}"
}
}
