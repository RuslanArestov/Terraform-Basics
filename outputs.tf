output "data" {
  value = [
    {
      vm1 = [
        yandex_compute_instance.platform.name,
        yandex_compute_instance.platform.network_interface[0].nat_ip_address,
        yandex_compute_instance.platform.fqdn
      ]
    },
    {
      vm2 = [
        yandex_compute_instance.db.name,
        yandex_compute_instance.db.network_interface[0].nat_ip_address,
        yandex_compute_instance.db.fqdn
      ]
    }
  ]
}
