#!/bin/bash -x

sysctl -w fs.inotify.max_user_instances=1024
sysctl -w fs.inotify.max_user_watches=1048576
apt install -y tcpdump



