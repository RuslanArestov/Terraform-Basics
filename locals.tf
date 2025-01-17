locals {
  ssh_public_key = file("~/.ssh/terraform_study.pub")
}

locals {

  web_vms = [for vm in yandex_compute_instance.web : {
    name = vm.name
    id   = vm.id
    fqdn = vm.network_interface[0].ip_address
  }]


  db_vms = [for vm in yandex_compute_instance.db_vms : {
    name = vm.name
    id   = vm.id
    fqdn = vm.network_interface[0].ip_address
  }]

  all_vms = concat(local.web_vms, local.db_vms)
}