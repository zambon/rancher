#!/bin/bash

REPO=${REPO:-rancher}
TAG=${TAG:-dev}
ARCH=${ARCH:-"$(docker version -f '{{.Server.Arch}}')"}

IMAGE=${REPO}/agent-base:${TAG}

docker build --build-arg ARCH=${ARCH} -t ${IMAGE}_${ARCH} .
echo Built ${IMAGE}_${ARCH}
