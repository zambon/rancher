#!/bin/bash

ARCH=${ARCH:-"$(docker version -f '{{.Server.Arch}}')"}

cd $(dirname $0)

if [ -z "$IMAGE" ]; then
    IMAGE=$(grep RANCHER_AGENT_IMAGE Dockerfile | awk '{print $3}')
fi

docker build --build-arg ARCH=${ARCH} -t ${IMAGE}_${ARCH} .
echo Built ${IMAGE}
