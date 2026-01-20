resource "yandex_compute_instance" "web" {
  count = 2
  depends_on = [yandex_compute_instance.web2]

  name = "web-${count.index + 1}"
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
