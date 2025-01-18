resource "yandex_vpc_network" "stage" {
  name = var.env_name
}

resource "yandex_vpc_subnet" "stage" {
  count = length(var.subnets)
  name   = "${var.env_name}-subnet-${count.index+1}"
  zone   = var.subnets[count.index].zone
  network_id     = yandex_vpc_network.stage.id
  v4_cidr_blocks = [var.subnets[count.index].cidr]
}
  