#!/bin/bash

ARCH=${ARCH:-"$(docker version -f '{{.Server.Arch}}')"}

cd $(dirname $0)

if [ -z "$IMAGE" ]; then
    IMAGE=$(grep RANCHER_AGENT_IMAGE Dockerfile | awk '{print $3}')
fi

echo Building ${IMAGE}
docker build --build-arg ARCH=${ARCH} -t ${IMAGE}_${ARCH} .

cat > image-manifest.yaml << EOF
image: ${IMAGE}
manifests:
  - image: ${IMAGE}_${ARCH}
    platform:
      architecture: ${ARCH}
      os: linux
EOF
