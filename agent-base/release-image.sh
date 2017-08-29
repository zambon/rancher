#!/bin/bash

REPO=${REPO:-rancher}
TAG=${TAG:-dev}

# Releasing from macOS requires setting REGISTRY_USERNAME and REGISRTY_PASSWORD
# Ref: https://github.com/estesp/manifest-tool#sample-usage
[ -n "$REGISTRY_USERNAME" ] && [ -n "$REGISTRY_PASSWORD" ] && \
  AUTH="--username $REGISTRY_USERNAME --password $REGISTRY_PASSWORD"

IMAGE=${REPO}/agent-base:${TAG}

manifest-tool ${AUTH} push from-args \
  --platforms linux/amd64,linux/ppc64le \
  --template ${IMAGE}_ARCH \
  --target ${IMAGE}
