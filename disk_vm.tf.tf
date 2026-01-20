resource "yandex_compute_disk" "boot-disk" {
  count    = 3
  name     = "virtual-hdd-${count.index + 1}"
  type     = "network-hdd"
  size     = 1
}

resource "yandex_compute_instance" "storage" {
  name = "storage"
  platform_id = var.vm_web_yandex_compute_instance_platform_id

  resources {
    cores         = 2
    memory        = 1
    core_fraction = 5
  }

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.image_id
    }
  }

  dynamic "secondary_disk" {
    for_each = yandex_compute_disk.boot-disk.*

    content {
      disk_id  = secondary_disk.value.id
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
