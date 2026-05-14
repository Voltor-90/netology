locals {
  vm_web_name = "${var.vpc_name}-${var.vm_web_name}"
  vm_db_name  = "${var.vpc_name}-${var.vm_db_name}"
}