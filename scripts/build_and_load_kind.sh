#!/usr/bin/env bash
set -euo pipefail

# Usage:
# REPO=local ./scripts/build_and_load_kind.sh

REPO="${REPO:-local}"

docker build -t ${REPO}/service-a:latest ./service-a
docker build -t ${REPO}/service-b:latest ./service-b

# load images into kind
kind load docker-image ${REPO}/service-a:latest --name demo || true
kind load docker-image ${REPO}/service-b:latest --name demo || true

echo "Images loaded into kind (cluster 'demo'): ${REPO}/service-a:latest, ${REPO}/service-b:latest"
