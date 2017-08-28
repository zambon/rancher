#!/bin/bash

REPO=${REPO:-rancher}
TAG=${TAG:-dev}

docker build --build-arg ARCH=$(uname -m) -t $REPO/agent-base:${TAG} .
echo Built $REPO/agent-base:${TAG}
