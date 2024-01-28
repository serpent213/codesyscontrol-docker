#!/bin/sh
VERSION=4.10.0.0

mkdir -p persist
docker run \
    --detach \
    --privileged \
    --network host \
    --volume /dev:/dev \
    --volume $(pwd)/persist:/var/opt \
    cscontrol:$VERSION
