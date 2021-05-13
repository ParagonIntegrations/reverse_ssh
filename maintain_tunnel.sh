#!/usr/bin/env bash

parent_path=$( cd "$(dirname "${BASH_SOURCE[0]}")" ; pwd -P )
cd "$parent_path"
runfile=$parent_path/setup_reverse_ssh.sh
keyfile=$parent_path/scriptlogin
port="2022"
host="reverse.paragonintegrations.co.za"
#echo " Starting $runfile"

until bash $runfile $port $keyfile $host ; do
    #echo "$runfile crashed with exit code $?.  Respawning.." >&2
    sleep 5
done