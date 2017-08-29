#!/bin/bash

REPO=${REPO:-rancher}
TAG=${TAG:-dev}
ARCH=${ARCH:-"$(docker version -f '{{.Server.Arch}}')"}

IMAGE=${REPO}/agent-base:${TAG}_${ARCH}

docker build --build-arg ARCH=${ARCH} -t ${IMAGE} .
echo Built ${IMAGE}
