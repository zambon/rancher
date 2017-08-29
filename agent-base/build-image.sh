#!/bin/bash

REPO=${REPO:-rancher}
TAG=${TAG:-dev}
ARCH=${ARCH:-"$(docker version -f '{{.Server.Arch}}')"}

IMAGE=${REPO}/agent-base:${TAG}_${ARCH}

docker build --build-arg ARCH=${ARCH} -t ${IMAGE} .
echo Built ${IMAGE}

cat > image-manifest.yaml << EOF
image: ${IMAGE}
manifests:
  - image: ${IMAGE}_${ARCH}
    platform:
      architecture: ${ARCH}
      os: linux
EOF
