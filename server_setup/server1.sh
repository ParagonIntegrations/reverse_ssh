#!/bin/bash
set -euo pipefail

# Name of the restricted user to create
USERNAME=scriptlogin

# Public keys to add to the new restricted user
# OTHER_PUBLIC_KEYS_TO_ADD=(
#     "ssh-rsa AAAAB..."
#     "ssh-rsa AAAAB..."
# )
OTHER_PUBLIC_KEYS_TO_ADD=(
	"ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQC8zcq91kD40jYsPNAchHoqDxKVJ+6SjsF+0g6Stz3HiAchzuQm/Pb7x7M5AUYHEvMXo4FOKrULc/v6SE9+YHKNs2UX1ut9vWCqLtT21IKAw6xIosTnwDZu137l9ryvQp8pKivpMLJz3DZCDT3sBYWXKFh/2K9POJlr70zifLBqoL6bQ5L5WCeGGiRkdY9CXLg9QhVCEPdAMpuwhjQCypRLI22e6Hxq+264W0FFNombFVBHhrHllexdkKCRrJRQVdoMqjk5/nBDMvJ39pCkrAIHMH7FmPcznR2p7BGd11Bk5p82435x8Sw5gXYDkU1wcOxl7Xlt30k1fTP8horG1lvl root@ccgx"
)

useradd --create-home --shell "/bin/true" "${USERNAME}"

# Create SSH directory for sudo user
home_directory="$(eval echo ~${USERNAME})"
mkdir --parents "${home_directory}/.ssh"

# Add additional provided public keys
for pub_key in "${OTHER_PUBLIC_KEYS_TO_ADD[@]}"; do
    echo "${pub_key}" >> "${home_directory}/.ssh/authorized_keys"
done

# Adjust SSH configuration ownership and permissions
chmod -R 0500 "${home_directory}"
chown --recursive "${USERNAME}":"${USERNAME}" "${home_directory}"