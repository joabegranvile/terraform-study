variable "token" {
  description = " Linode API token"
}

variable "stackscript_label" {
  description = "The StackScript's label is for display purposes only."
}

variable "description" {
  description = "A description for the StackScript."
}

variable "stackscript" {
  description = "The script to execute when provisioning a new Linode with this StackScript."
}

variable "stackscript_image" {
  description = "A list of Image IDs representing the Images that this StackScript is compatible for deploying with."
}

variable "rev_note" {
  description = "This field allows you to add notes for the set of revisions made to this StackScript."
}

variable "key" {
  description = "Public SSH Key's path."
}

variable "key_label" {
  description = "New SSH key label."
}

variable "image" {
  description = "Image to use for Linode instance."
  default = "linode/ubuntu22.04"
}

variable "label" {
  description = "The Linode's label is for display purposes only, but must be unique."
  default = "default-linode"
}

variable "region" {
  description = "The region where your Linode will be located."
  default = "us-east"
}

variable "type" {
  description = "Your Linode's plan type."
  default = "g6-standard-1"
}

variable "root_pass" {
  description = "Your Linode's root user's password."
}

variable "stackscript_data" {
  description = "Map of required StackScript UDF data."
  type = map
  default = {}
}

variable "stackscript_id" {
  description = "Hold the stackscript id output value."
}