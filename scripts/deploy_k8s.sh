#!/usr/bin/env bash
set -euo pipefail

# Replace placeholders if using a registry
REPO="${DOCKERHUB_REPO:-<DOCKERHUB_REPO>}"

kubectl apply -f k8s/namespace.yaml
# replace placeholder images in YAML if repo provided
if [ "${REPO}" != "<DOCKERHUB_REPO>" ]; then
  kubectl -n demo-microservices set image deployment/service-a service-a=${REPO}/service-a:latest || true
  kubectl -n demo-microservices set image deployment/service-b service-b=${REPO}/service-b:latest || true
fi

kubectl apply -f k8s/service-b-deployment.yaml
kubectl apply -f k8s/service-a-deployment.yaml
# optional ingress
# kubectl apply -f k8s/ingress.yaml

echo "Deployment applied to namespace demo-microservices"
kubectl -n demo-microservices get pods,svc
