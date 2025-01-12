resource "yandex_compute_instance" "web" {
  depends_on = [yandex_compute_instance.db_vms]
  count = 2
  name        = "web-${count.index + 1}"
  platform_id = var.vm_platform
  zone        = var.default_zone
  hostname   = "web-${count.index + 1}-${var.default_zone}.internal"

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

  scheduling_policy {
    preemptible = true
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.develop.id
    security_group_ids = [yandex_vpc_security_group.example.id]
    nat = true
  }

  metadata = {
  serial-port-enable = 1
  ssh-keys           = "ubuntu:${local.ssh_public_key}"
}
}
