#!/usr/bin/env bash

parent_path=$( cd "$(dirname "${BASH_SOURCE[0]}")" ; pwd -P )
cd "$parent_path"
runfile=$parent_path/maintain_tunnel.sh

# Remove the crontab entry
crontab -l | grep -v "@reboot $runfile"  | crontab -