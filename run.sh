#!/usr/bin/env bash

#
set -x

#docker pull dhnt/idea

# behind corporate firewall - http_proxy host needs to be ip address
# e.g. export http_proxy=http://10.10.10.10:8080

[ -z "$http_proxy" ] && proxy="" || proxy="-e http_proxy=$http_proxy -e https_proxy=$http_proxy -e no_proxy=$no_proxy"

#
ipaddr=$(ifconfig en0 | grep inet | awk '$1=="inet" {print $2}')

xhost + $ipaddr

#export DHNT_BASE=/c/Users/liqiang/AppData/.dhnt
[ -z "$DHNT_BASE" ] && export DHNT_BASE=~/.dhnt
export DISPLAY=${ipaddr}:0

volume="-v /private/tmp:/private/tmp -v ${DHNT_BASE}:/home/vcap"

docker run $proxy $volume -e DISPLAY=${DISPLAY} -it --rm --privileged --name dhnt-idea dhnt/idea
