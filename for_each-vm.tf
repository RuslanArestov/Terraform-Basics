resource "yandex_compute_instance" "db_vms" {
  for_each = { for vm in var.each_vm : vm.vm_name => vm }

  name        = each.value.vm_name
  platform_id = each.value.platform_id
  zone        = each.value.zone
  hostname    = each.value.hostname

  resources {
    cores           = each.value.cpu
    core_fraction   = each.value.core_fraction
    memory          = each.value.ram
  }

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.image_id
      size     = each.value.disk_volume
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