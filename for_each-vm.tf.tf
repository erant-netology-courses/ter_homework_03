variable "each_vm" {
  type = list(object({ vm_name=string, cpu=number, ram=number, core_fraction=number, disk_volume=number }))
  default = [
    {
      vm_name     = "main"
      cpu         = 2
      ram         = 1
      core_fraction = 5
      disk_volume = 30
    },
    {
      vm_name     = "replica"
      cpu         = 4
      ram         = 2
      core_fraction = 20
      disk_volume = 60
    }
  ]
}

resource "yandex_compute_instance" "web2" {
  for_each = { for vm in var.each_vm : vm.vm_name => vm }

  name = "web-${each.key}"
  platform_id = var.vm_web_yandex_compute_instance_platform_id

  resources {
    cores         = each.value.cpu
    memory        = each.value.ram
    core_fraction = each.value.core_fraction
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
    nat       = true
    security_group_ids = [yandex_vpc_security_group.example.id]
  }

  metadata = {
    serial-port-enable = 1
    ssh-keys           = file("~/.ssh/netology-ya-cloud")
  }
}
