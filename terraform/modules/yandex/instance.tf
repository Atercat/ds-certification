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
    subnet_id = "e9bv6q55u21o7f37i66l"
  }

  metadata = {
    ssh-keys = "ubuntu:${var.pub_key}"
  }
}