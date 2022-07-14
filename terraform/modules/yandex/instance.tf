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
    subnet_id = data.yandex_vpc_subnet.a.subnet_id
    nat       = true
  }

  metadata = {
    ssh-keys = "ubuntu:${var.pub_key}"
  }
}

data "yandex_vpc_subnet" "a" {
  name = "default-ru-central1-a"
}