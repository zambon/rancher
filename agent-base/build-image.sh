#!/bin/bash

REPO=${REPO:-rancher}
TAG=${TAG:-dev}

docker build --build-arg ARCH=$(go env GOARCH) -t $REPO/agent-base:${TAG} .
echo Built $REPO/agent-base:${TAG}
