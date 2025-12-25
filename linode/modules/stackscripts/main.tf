terraform {
  required_providers {
    linode = {
      source = "linode/linode"
    }
  }
}


resource "linode_stackscript" "default" {
  label = var.stackscript_label
  description = var.description
  script = var.stackscript
  images = var.stackscript_image
  rev_note = var.rev_note
}