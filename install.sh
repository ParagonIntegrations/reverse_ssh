#!/usr/bin/env bash

#Hosts to add
# HOSTS_TO_ADD=(
#     "192.168.1.1 ssh-rsa AAAAB..."
#     "192.168.1.1 ssh-rsa AAAAB..."
# )
HOSTS_TO_ADD=(
"reverse.paragonintegrations.co.za,206.189.1.69 ecdsa-sha2-nistp256 AAAAE2VjZHNhLXNoYTItbmlzdHAyNTYAAAAIbmlzdHAyNTYAAABBBNJo2Y8S8zFSmgmX34zgW/6Hvat+3ZsgrrevUu8Eb7oWpMRTT87jHP+/0m0gtnXMzt+LJC2KKfDrN6H5xDxU06c="
)

parent_path=$( cd "$(dirname "${BASH_SOURCE[0]}")" ; pwd -P )
cd "$parent_path"
runfile=$parent_path/maintain_tunnel.sh

# Fix permissions for the runfile and the keyfile
chmod 755 $runfile
chmod 600 $parent_path/scriptlogin

# Add the host to the knownhosts
for pub_key in "${HOSTS_TO_ADD[@]}"; do
    echo "${pub_key}" >> ~/.ssh/known_hosts
done

# Add the file to the crontab
! (crontab -l | grep -q "$runfile") && (crontab -l; echo "@reboot $runfile") | crontab -