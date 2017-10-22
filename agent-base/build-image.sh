#!/bin/bash

REPO=${REPO:-rancher}
TAG=${TAG:-dev}
ARCH=${ARCH:-"$(docker version -f '{{.Server.Arch}}')"}

IMAGE=${REPO}/agent-base:${TAG}_${ARCH}

docker build -t $IMAGE .
echo Built $IMAGE
