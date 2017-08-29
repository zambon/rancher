#!/bin/bash

IMAGE=${IMAGE:-"$(grep RANCHER_AGENT_IMAGE Dockerfile | awk '{print $3}')"}

# Releasing from macOS requires setting REGISTRY_USERNAME and REGISRTY_PASSWORD
# Ref: https://github.com/estesp/manifest-tool#sample-usage
[ -n "$REGISTRY_USERNAME" ] && [ -n "$REGISTRY_PASSWORD" ] && \
  AUTH=(--username "$REGISTRY_USERNAME" --password "$REGISTRY_PASSWORD")

[ -n "${AUTH[*]}" ] && docker login -u "$REGISTRY_USERNAME" -p "$REGISTRY_PASSWORD" "$REGISTRY_HOST"
docker push ${IMAGE}_amd64
docker push ${IMAGE}_ppc64le
[ -n "${AUTH[*]}" ] && docker logout "$REGISTRY_HOST"

manifest-tool "${AUTH[@]}" push from-args \
  --platforms linux/amd64,linux/ppc64le \
  --template ${IMAGE}_ARCH \
  --target ${IMAGE}
