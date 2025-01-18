output "vpc_id" {
  value       = yandex_vpc_network.stage.id
}

output "subnet_ids" {
  value       = [for subnet in yandex_vpc_subnet.stage : subnet.id]
}
