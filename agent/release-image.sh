#!/bin/bash

if [ -z "$IMAGE" ]; then
  IMAGE=$(grep RANCHER_AGENT_IMAGE Dockerfile | awk '{print $3}')
fi

# Releasing from macOS requires setting REGISTRY_USERNAME and REGISRTY_PASSWORD
# Ref: https://github.com/estesp/manifest-tool#sample-usage
[ -n "$REGISTRY_USERNAME" ] && [ -n "$REGISTRY_PASSWORD" ] && \
  AUTH="--username $REGISTRY_USERNAME --password $REGISTRY_PASSWORD"

manifest-tool ${AUTH} push from-args \
  --platforms linux/amd64,linux/ppc64le \
  --template ${IMAGE}_ARCH \
  --target ${IMAGE}
