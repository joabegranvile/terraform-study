locals {
  key = var.key
}

terraform {
  required_providers {
    linode = {
      source = "linode/linode"
    }
  }
}

resource "linode_sshkey" "this" {
  label = var.key_label
  ssh_key = trimspace(file(var.key))
}


resource "linode_instance" "linode_id" {
  image = var.image
  label = var.label
  region = var.region
  type = var.type
  root_pass = var.root_pass
  authorized_keys = [linode_sshkey.this.ssh_key]
  stackscript_id = var.stackscript_id
  stackscript_data = {
    "my_password" = var.stackscript_data["my_password"]
    "my_username" = var.stackscript_data["my_username"]
    "my_hostname" = var.stackscript_data["my_hostname"]
    "my_userpubkey" = var.stackscript_data["my_userpubkey"]
  }
}

