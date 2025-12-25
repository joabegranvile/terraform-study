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
  description = " A list of Image IDs representing the Images that this StackScript is compatible for deploying with."
  default = "linode/ubuntu22.04"
}
variable "rev_note" {
  description = "This field allows you to add notes for the set of revisions made to this StackScript."
}