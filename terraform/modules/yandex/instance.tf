resource "yandex_compute_instance" "vm" {
  name = var.name

  resources {
    cores  = 2
    memory = 2
  }

  boot_disk {
    initialize_params {
      image_id = var.image_id
      size     = var.storage_size
      type     = "network-ssd"
    }
  }

  network_interface {
    subnet_id = "${yandex_vpc_network.default.subnet_ids[0]}"
  }

  metadata = {
    ssh-keys = "ubuntu:${var.pub_key}"
  }
}

data "yandex_vpc_network" "default" {
  name = "default"
}