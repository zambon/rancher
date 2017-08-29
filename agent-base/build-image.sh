#!/bin/bash

REPO=${REPO:-rancher}
TAG=${TAG:-dev}
ARCH=${ARCH:-"$(docker version -f '{{.Server.Arch}}')"}

IMAGE=${REPO}/agent-base:${TAG}

docker build --build-arg ARCH=${ARCH} -t ${IMAGE}_${ARCH} .
echo Built ${IMAGE}_${ARCH}

cat > image-manifest.yaml << EOF
image: ${IMAGE}
manifests:
  - image: ${IMAGE}_${ARCH}
    platform:
      architecture: ${ARCH}
      os: linux
EOF
