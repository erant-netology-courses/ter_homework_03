resource "local_file" "hosts_templatefile" {
  content = templatefile("${path.module}/hosts.tftpl", {
    countservers = [
      for id in range(length(yandex_compute_instance.web)) : {
        name = yandex_compute_instance.web[id].name
        ip   = yandex_compute_instance.web[id].network_interface[0].ip_address
        fqdn = yandex_compute_instance.web[id].fqdn
      }
    ]
    foreachservers = [
      for vm in values(yandex_compute_instance.web2) : {
        name = vm.name
        ip   = vm.network_interface[0].ip_address
        fqdn = vm.fqdn
      }
    ]
    storageserver = [
      {
        name = yandex_compute_instance.storage.name
        ip   = yandex_compute_instance.storage.network_interface[0].ip_address
        fqdn = yandex_compute_instance.storage.fqdn
      }
    ]
  })

  filename = "${abspath(path.module)}/hosts.ini"
}
