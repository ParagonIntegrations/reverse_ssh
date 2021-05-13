#!/usr/bin/env bash

ssh_tunnel_port="$1"
keyfile="$2"
target_host="$3"

terminate(){
  #echo "Terminating gracefully"
  exit 0
}

trap "terminate" SIGINT SIGTERM

for target_port in 80 443 22; do
  #echo "Trying to connect via port $target_port"
  ssh -o ExitOnForwardFailure=yes -o ConnectTimeout=20 -o ServerAliveInterval=10 -o ServerAliveCountMax=3 -o TCPKeepAlive=yes -o StrictHostKeyChecking=yes -p "$target_port" -N -R "$ssh_tunnel_port":localhost:22 -i "$keyfile" "scriptlogin@$target_host"
done

exit 1