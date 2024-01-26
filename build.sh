#!/bin/sh
VERSION=4.10.0.0

docker build --progress=plain --tag cscontrol:$VERSION --build-arg CONTROL_VERSION=$VERSION .
