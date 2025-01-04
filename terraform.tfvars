vpc_name                    = "develop"
vm_web_image_family         = "ubuntu-2004-lts"

vm_web_platform             = "standard-v1"
vm_web_name_resource  = "netology-develop-platform-web"
name_subnet_1                = "subnet-1"
default_cidr                = ["10.0.1.0/24"]
default_zone                = "ru-central1-a"

vm_db_platform              = "standard-v1"
vm_db_name_resource   = "netology-develop-platform-db"
name_subnet_2               = "subnet-2"
subnet_for_vm_db            = ["10.0.2.0/24"]
zone_for_vm_db              = "ru-central1-b"

vms_resources = {
  web = {
    cores         = 2
    memory        = 2
    core_fraction = 5
    hdd_size      = 10
    hdd_type      = "network-hdd"
  },
  db = {
    cores         = 2
    memory        = 4
    core_fraction = 20
    hdd_size      = 10
    hdd_type      = "network-ssd"
  }
}

metadata = {
  serial-port-enable = 1
  ssh-keys           = "ubuntu:ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJJ4/VN3BZ/lju2S4Yva3yFk8TyAJcCL6Xo+Pv5RKZYE"
}

test = [
  {
    "dev1" = [
      "ssh -o 'StrictHostKeyChecking=no' ubuntu@62.84.124.117",
      "10.0.1.7",
    ]
  },
  {
    "dev2" = [
      "ssh -o 'StrictHostKeyChecking=no' ubuntu@84.252.140.88",
      "10.0.2.29",
    ]
  },
  {
    "prod1" = [
      "ssh -o 'StrictHostKeyChecking=no' ubuntu@51.250.2.101",
      "10.0.1.30",
    ]
  },
]
