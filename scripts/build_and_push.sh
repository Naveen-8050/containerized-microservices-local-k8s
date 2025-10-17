#!/usr/bin/env bash
set -euo pipefail

# Usage:
# DOCKERHUB_REPO=youruser ./scripts/build_and_push.sh

REPO="${DOCKERHUB_REPO:?set DOCKERHUB_REPO env var (e.g. myuser)}"

# Build images
docker build -t ${REPO}/service-a:latest ./service-a
docker build -t ${REPO}/service-b:latest ./service-b

# Push
docker push ${REPO}/service-a:latest
docker push ${REPO}/service-b:latest

echo "Images pushed: ${REPO}/service-a:latest, ${REPO}/service-b:latest"

