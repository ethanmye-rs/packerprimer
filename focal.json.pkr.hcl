source "hyperv-iso" "focal" {
  boot_wait = "4s"
  boot_command = [
    "<esc><esc><esc>",
    "set gfxpayload=keep<enter>",
    "linux /casper/vmlinuz ",
    "\"ds=nocloud-net;s=http://{{ .HTTPIP }}:{{ .HTTPPort }}/\" ",
    "quiet autoinstall ---<enter>",
    "initrd /casper/initrd<enter>",
    "boot<enter>",
  ]
  headless               = false
  switch_name            = "Default Switch"
  http_directory         = "http"
  iso_checksum           = "28ccdb56450e643bad03bb7bcf7507ce3d8d90e8bf09e38f6bd9ac298a98eaad"
  iso_url                = "source/ubuntu-20.04.4-live-server-amd64.iso"
  memory                 = var.memory # variable example
  ssh_password           = "ubuntu"
  ssh_username           = "ubuntu"
  ssh_timeout            = "2h"
  ssh_handshake_attempts = 20
  communicator           = "ssh"
  shutdown_command       = "echo 'packer' | sudo -S shutdown -P now"
  generation             = 2
}

source "hyperv-iso" "jammy" {
  boot_wait = "4s"
  boot_command = [
    "<esc><esc><esc>",
    "set gfxpayload=keep<enter>",
    "linux /casper/vmlinuz ",
    "\"ds=nocloud-net;s=http://{{ .HTTPIP }}:{{ .HTTPPort }}/\" ",
    "quiet autoinstall ---<enter>",
    "initrd /casper/initrd<enter>",
    "boot<enter>",
  ]
  headless               = false
  switch_name            = "Default Switch"
  http_directory         = "http"
  iso_checksum           = "28ccdb56450e643bad03bb7bcf7507ce3d8d90e8bf09e38f6bd9ac298a98eaad"
  iso_url                = "source/ubuntu-20.04.4-live-server-amd64.iso"
  memory                 = var.memory # variable example
  ssh_password           = "ubuntu"
  ssh_username           = "ubuntu"
  ssh_timeout            = "2h"
  ssh_handshake_attempts = 20
  communicator           = "ssh"
  shutdown_command       = "echo 'packer' | sudo -S shutdown -P now"
  generation             = 2
}

source "qemu" "focal" {
  iso_url                = "source/ubuntu-20.04.4-live-server-amd64.iso"
  iso_checksum           = "28ccdb56450e643bad03bb7bcf7507ce3d8d90e8bf09e38f6bd9ac298a98eaad"
  output_directory       = "kvm-focal"
  shutdown_command       = "echo 'packer' | sudo -S shutdown -P now"
  disk_size              = "8G"
  memory                 = var.memory # variable example
  format                 = "qcow2"    #raw also supported
  accelerator            = "kvm"
  http_directory         = "http"
  ssh_username           = "ubuntu"
  ssh_password           = "ubuntu"
  ssh_timeout            = "2h"
  shutdown_timeout       = "2h"
  ssh_handshake_attempts = 2000
  vm_name                = "example"
  net_device             = "virtio-net"
  disk_interface         = "virtio"
  boot_wait              = "3s"
  firmware               = "OVMF.fd"
  boot_command = [
    "<esc><esc><esc>",
    "linux /casper/vmlinuz ",
    "\"ds=nocloud-net;s=http://{{ .HTTPIP }}:{{ .HTTPPort }}/\" ",
    "autoinstall ---<enter>",
    "initrd /casper/initrd<enter>",
    "boot<enter>",
  ]

}

source "qemu" "jammy" {
  iso_url                = "source/ubuntu-22.04.1-live-server-amd64.iso"
  iso_checksum           = "10f19c5b2b8d6db711582e0e27f5116296c34fe4b313ba45f9b201a5007056cb"
  output_directory       = "kvm-output"
  shutdown_command       = "shutdown now"
  disk_size              = "8G"
  memory                 = var.memory # variable example
  format                 = "qcow2"
  accelerator            = "kvm"
  http_directory         = "http"
  ssh_username           = "ubuntu"
  ssh_password           = "ubuntu"
  ssh_timeout            = "2h"
  shutdown_timeout       = "2h"
  ssh_handshake_attempts = 2000
  vm_name                = "example"
  net_device             = "virtio-net"
  disk_interface         = "virtio"
  boot_wait              = "4s"
  firmware               = "OVMF.fd"
  boot_command = [
    "c",
    "linux /casper/vmlinuz ",
    "\"ds=nocloud-net;s=http://{{ .HTTPIP }}:{{ .HTTPPort }}/\" ",
    "autoinstall ---<enter>",
    "initrd /casper/initrd<enter>",
    "boot<enter>",
  ]
}

source "lxd" "focal" {
  image        = "ubuntu:focal"
  output_image = "packer-focal"

  #https://stgraber.org/2016/03/30/lxd-2-0-image-management-512/
  publish_properties = {
    description = "Base LXD packer template"
  }
  virtual_machine = true
}

source "lxd" "jammy" {
  image        = "ubuntu:jammy"
  output_image = "packer-jammy"

  #https://stgraber.org/2016/03/30/lxd-2-0-image-management-512/
  publish_properties = {
    description = "Base LXD packer template"
  }
  virtual_machine = true
}

source "vmware-iso" "focal" {
  iso_url          = "source/ubuntu-20.04.4-live-server-amd64.iso"
  iso_checksum     = "28ccdb56450e643bad03bb7bcf7507ce3d8d90e8bf09e38f6bd9ac298a98eaad"
  ssh_username     = "ubuntu"
  ssh_password     = var.sudo_password #secret varaiable example
  shutdown_command = "shutdown -P now"
  http_directory   = "http"
  disk_size        = 40960
  disk_type_id     = 0
  guest_os_type    = "ubuntu64Guest"
  vm_name          = "PackerVM"
  cpus             = 2
  memory           = var.memory
  boot_command = [
    "<esc><esc><esc>",
    "<enter><wait>",
    "/casper/vmlinuz ",
    "root=/dev/sr0 ",
    "initrd=/casper/initrd ",
    "autoinstall ",
    "ds=nocloud-net;s=http://{{ .HTTPIP }}:{{ .HTTPPort }}/",
    "<enter>"
  ]
  boot_wait = "5s"
  ssh_port  = 22
}


source "vmware-iso" "jammy" {
  iso_url          = "source/ubuntu-22.04.1-live-server-amd64.iso"
  iso_checksum     = "10f19c5b2b8d6db711582e0e27f5116296c34fe4b313ba45f9b201a5007056cb"
  ssh_username     = "ubuntu"
  ssh_password     = var.sudo_password #secret varaiable example
  shutdown_command = "shutdown -P now"
  http_directory   = "http"
  disk_size        = 40960
  disk_type_id     = 0
  guest_os_type    = "ubuntu64Guest"
  vm_name          = "PackerVM"
  cpus             = 2
  memory           = var.memory
  boot_command = [
    "<esc><esc><esc>",
    "<enter><wait>",
    "/casper/vmlinuz ",
    "root=/dev/sr0 ",
    "initrd=/casper/initrd ",
    "autoinstall ",
    "ds=nocloud-net;s=http://{{ .HTTPIP }}:{{ .HTTPPort }}/",
    "<enter>"
  ]
  boot_wait = "5s"
  ssh_port  = 22
}

build {
  sources = ["lxd.jammy"] #swap this to build different images

  provisioner "shell" {
    inline = ["ls /"]
  }

  post-processor "shell-local" {
    inline = ["echo foo"]
  }
}
