locals {
  countVMs = { for id in range(length(yandex_compute_instance.web)) :
    yandex_compute_instance.web[id].name => {
      name = yandex_compute_instance.web[id].name
      ip   = yandex_compute_instance.web[id].network_interface[0].ip_address
      fqdn = yandex_compute_instance.web[id].fqdn
    }
  }
  foreachVMs = {
    for vm in values(yandex_compute_instance.web2) :
      vm.name => {
        name = vm.name
        ip   = vm.network_interface[0].ip_address
        fqdn = vm.fqdn
      }
  }
}

output "vm_instances" {
  value = merge(local.countVMs, local.foreachVMs)
}