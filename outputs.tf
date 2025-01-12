output "webservers" {
  value = [
    for vm in yandex_compute_instance.web : {
      name = vm.name
      id   = vm.id
      fqdn = vm.fqdn
    }
  ]
}

output "databases" {
  value = [
    for vm in yandex_compute_instance.db_vms : {
      name = vm.name
      id   = vm.id
      fqdn = vm.fqdn
    }
  ]
}