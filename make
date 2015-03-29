#!/bin/sh
set -x
set -e

# If you are on CoreOS or similar minimal OS,
# you do not have the `make' command.
# This simple script compensates for that.
#
# Note: We use `docker cp' instead of a volume mount
# to enable a person to build on a remote docker host.
# Example:
#
#   export DOCKER_HOST='tcp://192.168.254.162:2375'
#   ./make runtime

usage() {
  echo 'Usage: ./make [builder|runtime|clean]' >&2
  exit 1
}

builder() {
  cp -f builder.dockerfile Dockerfile
  docker build -t httpdiff_builder .
}

runtime() {
  docker images | grep httpdiff_builder || builder
  docker rm -f builder &> /dev/null || :
  docker run --name builder httpdiff_builder
  docker cp builder:/home/developer/httpdiff .
  cp -f runtime.dockerfile Dockerfile
  docker build -t httpdiff .
  docker images | grep -e SIZE -e httpdiff
}

clean() {
  rm httpdiff
  docker rm -f httpdiff_builder
  docker rmi -f httpdiff_builder
  docker rmi -f httpdiff
  docker images | awk '/<none>/ {print $3}' | xargs docker rmi
}

test() {
  # The image uses `-help' as the default option.
  # It exits 0 (good) if the `-help' works and non-zero otherwise.
  # Therefore we do not need to grep output.
  docker run -it -v /tmp:/tmp httpdiff
}

main() {
  [ "x${1}" = "x" ] && usage || ${1}
}

main ${1}
