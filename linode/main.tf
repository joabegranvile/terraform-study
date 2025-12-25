terraform {
  required_providers {
    linode = {
      source = "linode/linode"
      version = "3.0.0"
    }
  }
}
provider "linode" {
  token = var.token
}

module "stackscripts" {
  source = "./modules/stackscripts"
  stackscript_label = var.stackscript_label
  description = var.description
  stackscript = var.stackscript
  stackscript_image = var.stackscript_image
  rev_note = var.rev_note
}

module "linodes" {
    source = "./modules/linodes"
    key = var.key
    key_label = var.key_label
    image = var.image
    label = var.label
    region = var.region
    type = var.type
    root_pass = var.root_pass
    stackscript_id = module.stackscripts.stackscript_id
    stackscript_data = {
       "my_password" = var.stackscript_data["my_password"]
       "my_userpubkey" = var.stackscript_data["my_userpubkey"]
       "my_hostname" = var.stackscript_data["my_hostname"]
       "my_username" = var.stackscript_data["my_username"]
    }
}