terraform {
  required_providers {
    yandex = {
      source  = "yandex-cloud/yandex"
      version = "0.84.0"
    }
  }
}

resource "yandex_compute_instance" "app" {
  name = "reddit-app"

  labels = {
    tags = "reddit-app"
  }
  resources {
    cores  = 2
    memory = 4
  }

  boot_disk {
    initialize_params {
      image_id = var.app_disk_image
    }
  }

  network_interface {
    subnet_id = var.subnet_id
    nat       = true
  }

  metadata = {
    user-data = "#cloud-config\nusers:\n  - name: appuser\n    groups: sudo\n    shell: /bin/bash\n    sudo: ['ALL=(ALL) NOPASSWD:ALL']\n    ssh-authorized-keys:\n      - ${file(var.public_key_path)}"
  }

}
data "yandex_vpc_network" "vpc" {
  name = "default"
}
resource "yandex_vpc_security_group" "nsg" {
  name        = "app security group"
  description = "description for app security group"
  network_id  = data.yandex_vpc_network.vpc.id
}
resource "yandex_vpc_security_group_rule" "port-80" {
  security_group_binding = yandex_vpc_security_group.nsg.id
  direction              = "ingress"
  description            = "port-80"
  v4_cidr_blocks         = ["0.0.0.0/0"]
  port                   = 80
  protocol               = "TCP"
}
