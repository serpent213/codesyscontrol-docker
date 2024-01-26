#!/bin/sh
mkdir -p persist
docker run \
    --detach \
    --privileged \
    --network host \
    --volume $(pwd)/persist:/var/opt \
    reactor.de/cscontrol:4.10.0.0
