locals {
  vm_web_name = "${var.vpc_name}-${var.vm_web_name_resource}"
  vm_db_name  = "${var.vpc_name}-${var.vm_db_name_resource}"
}