variable "key" {
  type = string
  description = "Public SSH key's path."
}

variable "key_label" {
  type = string
  description = "new SSH key label"
}

variable "image" {
  type = string
  description = "Linode Image to deploy"
  default = "linode/ubuntu22.04"
}

variable "label" {
  description = "The Linode`s label"
  default = "default-linode"
}

variable "region" {
  description = "The region where your Line will be located"
}

variable "type" {
  description = "Your Linode`s plan type"
  default = "g6-nanode-1"
}

variable "authorized_keys" {
  type = list(string)
  description = "A list of SSH public keys to be added to the Linode"
  default = []
}

variable "root_pass" {
  description = "Your Linode`s root user`s password"
}

variable "stackscript_id" {
  type = number
  description = "The ID of the StackScript to deploy on the Linode"
}

variable "stackscript_data" {
  description = "Map of required StackScript UDF data"
  type = map
  default = {}
}