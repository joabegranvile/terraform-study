key = "~/.ssh/id_rsa.pub"
key_label = "my-ssh-key"
label = "my-linode"
stackscript_id = "base-ubuntu-deployment"
stackscript_label = "base-ubuntu-deployment"
description = "A base deployment for Ubuntu 18.04 that creates a limited user account."
stackscript = <<EOF
#!/bin/bash
# <UDF name="my_hostname" Label="Linode's Hostname" />
# <UDF name="my_username" Label="Limited user account" />
# <UDF name="my_password" Label="Limited user account's password" />
# <UDF name="my_userpubkey" Label="Limited user account's public key" />

source <ssinclude StackScriptID="1">

set -x

MY_IP=system_primary_ip
system_set_hostname "$MY_HOSTNAME"
system_add_host_entry "$MY_IP" "$MY_HOSTNAME"
user_add_sudo "$MY_USERNAME" "$MY_PASSWORD"
user_add_pubkey "$MY_USERNAME" "$MY_USERPUBKEY"
ssh_disable_root
goodstuff
EOF
stackscript_image = ["linode/ubuntu22.04"]
rev_note = "First revision of my StackScript created with the Linode Terraform provider."