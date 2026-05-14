cloud_id  = "b1g3fqlj21dnb1c23smt"
folder_id = "b1gi934g8h4it18f90mk"

vms_resources = {
  web = {
    cores         = 2
    memory        = 1
    core_fraction = 20
    hdd_size      = 10
    hdd_type      = "network-hdd"
  }
  db = {
    cores         = 2
    memory        = 2
    core_fraction = 20
    hdd_size      = 10
    hdd_type      = "network-hdd"
  }
}
metadata = {
  serial-port-enable = "1"
  ssh-keys           = "ubuntu:ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIPKpey95gv/azDCbv2hH7z4rYLil9oONEdAfuIL3UcWm voltor@debian"
}